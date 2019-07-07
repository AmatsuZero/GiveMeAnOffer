//
// Created by daubert on 19-7-4.
//

import Foundation

class QRCode {
    static let PAD0 =  0xEC
    static let PAD1 = 0x11
    
    var type: Int
    var errorCorrectLevel: QRErrorCorrectLevel
    var dataList = [QR8BitByte]()
    private(set) var moduleCount = 0
    var modules = [[Bool?]]()
    var dataCache: [Int]?
    
    enum QRCodeError: CustomNSError {
        static var errorDomain: String {
            return "com.daubert.qrCode"
        }
        
        case isDark(Int, Int)
        
        var errorCode: Int {
            return -104
        }
        
        var errorUserInfo: [String : Any] {
            switch self {
            case .isDark(let row, let col):
                return [NSLocalizedDescriptionKey: "row: \(row) col: \(col)"]
            }
        }
    }
    
    init(type: Int, errorCorrectLevel: QRErrorCorrectLevel) {
        self.type = type
        self.errorCorrectLevel = errorCorrectLevel
    }
    
    func add(data: String) {
        dataList.append(QR8BitByte(data: data))
        dataCache = nil
    }
    
    func isDark(row: Int, col: Int) throws -> Bool? {
        guard row >= 0, moduleCount > row, col >= 0, moduleCount > col else {
            throw QRCodeError.isDark(row, col)
        }
        return modules[row][col]
    }
    
    func make() throws {
        // Calculate automatically typeNumber if provided is < 1
        guard type < 1 else {
            try makeImpl(test: false, maskPattern: try getBestMaskPattern())
            return
        }
        
        var typeNum = 1
        while typeNum < 40 {
            let rsBlocks = errorCorrectLevel.rsBlocks(type: typeNum)
            var buffer = QRBitBuffer()
            
            var totalDataCount = 0
            rsBlocks.forEach { totalDataCount += $0.dataCount }
            
            for data in dataList {
                buffer.put(num: data.mode.value, length: 4)
                buffer.put(num: data.length, length: try data.mode.getLengthInBits(type: typeNum))
                data.write(buffer: &buffer)
            }
            
            if buffer.length <= totalDataCount * 8 {
                break
            }
            
            typeNum += 1
        }
        self.type = typeNum
        try makeImpl(test: false, maskPattern: try getBestMaskPattern())
    }
}

fileprivate extension QRCode {
    func setupPositionProbePattern(row: Int, col: Int) {
        for r in -1...7 where row + r > -1 && moduleCount > row + r {
            for c in -1...7 where col + c > -1 && moduleCount > col + c {
                var ret = (0 <= r && r <= 6 && (c == 0 || c == 6))
                if !ret {
                    ret = ret || (0 <= c && c <= 6 && (r == 0 || r == 6))
                }
                if !ret {
                    ret = ret || (2 <= r && r <= 4 && 2 <= c && c <= 4)
                }
                modules[row+r][col+c] = ret
            }
        }
    }
    
    func setupPositionAdjustPattern() {
        let pos = self.type.patterPosition()
        for i in 0..<pos.count {
            for j in 0..<pos.count {
                
                let row = pos[i]
                let col = pos[j]
                
                guard modules[row][col] != nil else {
                    continue
                }
                
                for r in -2...2 {
                    for c in -2...2 {
                        var ret = abs(r) == 2
                        if !ret {
                            ret = ret || abs(c) == 2
                        }
                        if !ret {
                            ret = ret || (r == 0 && c == 0)
                        }
                        modules[row+r][col+c] = ret
                    }
                }
            }
        }
    }
    
    func setupTimingPattern() {
        for r in 8..<moduleCount - 8 where modules[r][6] != nil {
            modules[r][6] = r % 2 == 0
        }
        
        for c in 8..<moduleCount - 8 where modules[c][6] != nil {
            modules[6][c] = c % 2 == 0
        }
    }
}

fileprivate extension QRCode {
    func setupTypeInfo(test: Bool, maskPattern: QRMaskPattern) {
        let data = self.errorCorrectLevel.rawValue << 3 | maskPattern.rawValue
        let bits = data.bchTypeInfo()
        
        var mod = false
        
        // vertical
        for v in 0..<15 {
            mod = (!test && ((bits >> v) & 1) == 1)
            if v < 6 {
                modules[v][8] = mod
            } else if v < 8 {
                modules[v + 1][8] = mod
            } else {
                modules[moduleCount - 15 + v][8] = mod
            }
        }
        
        // horizontal
        for h in 0..<15 {
            mod = (!test && ((bits >> h) & 1) == 1)
            if h < 8 {
                modules[8][moduleCount - h - 1] = mod
            } else if h < 9 {
                modules[8][15 - h - 1 + 1] = mod
            } else {
                modules[8][15 - h - 1] = mod
            }
        }
        
        // fixed module
        modules[moduleCount - 8][8] = !test
    }
    
    func setupTypeNumber(test: Bool) {
        let bits = type.bchTypeNumber()
        var mod = false
        
        for i in 0..<18 {
            mod = (!test && ((bits >> i) & 1) == 1)
            modules[Int(floor(Float(i / 3)))][i % 3 + moduleCount - 8 - 3] = mod
        }
        
        for x in 0..<18 {
            mod = (!test && ((bits >> x) & 1) == 1)
            modules[x % 3 + moduleCount - 8 - 3][Int(floor(Float(x / 3)))] = mod
        }
    }
    
    func getBestMaskPattern() throws -> QRMaskPattern {
        var minLostPoint = 0
        var bestMatchPattern = QRMaskPattern.PATTERN000
        
        for pattern in QRMaskPattern.allCases {
            
            try makeImpl(test: true, maskPattern: pattern)
            let lostPoint = try getLostPoint()
            
            if pattern == .PATTERN000 || minLostPoint > lostPoint {
                minLostPoint = lostPoint
                bestMatchPattern = pattern
            }
        }
        
        return bestMatchPattern
    }
    
    func makeImpl(test: Bool, maskPattern: QRMaskPattern) throws {
        moduleCount = type * 4 + 17
        modules = [[Bool?]](repeating: [Bool?](), count: moduleCount)
        
        for row in 0..<moduleCount {
            modules[row] = [Bool?](repeating: nil, count: moduleCount)
        }
        
        setupPositionProbePattern(row: 0, col: 0)
        setupPositionProbePattern(row: moduleCount - 7, col: 0)
        setupPositionProbePattern(row: 0, col: moduleCount - 7)
        setupPositionAdjustPattern()
        setupTypeInfo(test: test, maskPattern: maskPattern)

        if type >= 7 {
            setupTypeNumber(test: test)
        }
        
        if dataCache == nil {
            dataCache = try QRCode.createData(type: type, errorCorrecLevel: errorCorrectLevel, dataList: dataList)
        }
        
        map(data: dataCache!, maskPattern: maskPattern)
    }
    
    func map(data: [Int], maskPattern: QRMaskPattern) {
        var inc = -1,
        row = moduleCount - 1,
        bitIndex = 7,
        byteIndex = 0
        
        var col = moduleCount - 1
        
        while col > 0 {
            if col == 6 {
                col -= 1
            }
            
            while true {
                for c in 0..<2 where modules[row][col-c] == nil {
                    var dark = false
                    
                    if byteIndex < data.count {
                        dark = (Int(Int64(data[byteIndex]) >>> Int64(bitIndex)) & 1) == 1
                    }
                    
                    if maskPattern.getMask(row, col - c) {
                        dark.toggle()
                    }
                    
                    modules[row][col-c] = dark
                    bitIndex -= 1
                    
                    if bitIndex == -1 {
                        byteIndex += 1
                        bitIndex = 7
                    }
                }
                
                row += inc
                if row < 0 || moduleCount <= row {
                    row -= inc
                    inc = -inc
                    break
                }
            }
            
            col -= 2
        }
    }
    
    func getLostPoint() throws -> Int {
        var lostPoint = 0
        
        // LEVEL1
        for row in 0..<moduleCount {
            for col in 0..<moduleCount {
                var sameCount = 0
                let dark = try isDark(row: row, col: col)
                for r in -1...1 where row + r >= 0 && moduleCount > row + r {
                    for c in -1...1 where col + c >= 0 && moduleCount > col + c {
                        guard r != 0 || c != 0 else {
                            continue
                        }
        
                        if dark == (try isDark(row: row + r, col: col + c)) {
                            sameCount += 1
                        }
                    }
                }
                
                if sameCount > 5 {
                    lostPoint += 3 + sameCount - 5
                }
            }
        }
        
        // LEVEL2
        for row in 0..<moduleCount - 1 {
            for col in 0..<moduleCount - 1 {
                var count = 0
                if try isDark(row: row, col: col) == true {
                    count += 1
                }
                
                if try isDark(row: row + 1, col: col) == true {
                    count += 1
                }
                
                if try isDark(row: row, col: col + 1) == true {
                    count += 1
                }
                
                if try isDark(row: row + 1, col: col + 1) == true {
                    count += 1
                }
                
                if count == 0 || count == 4 {
                    lostPoint += 3
                }
            }
        }
        
        // LEVEL3
        for row in 0..<moduleCount {
            for col in 0..<moduleCount - 6 {
                guard var ret = try isDark(row: row, col: col) else {
                    continue
                }
                
                if ret, let v = try isDark(row: row, col: col + 1) {
                    ret = ret && !v
                }
                
                if ret, let v = try isDark(row: row, col: col + 2) {
                    ret = ret && v
                }
                
                if ret, let v = try isDark(row: row, col: col + 3) {
                    ret = ret && v
                }
                
                if ret, let v = try isDark(row: row, col: col + 4) {
                    ret = ret && v
                }
                
                if ret, let v = try isDark(row: row, col: col + 5) {
                    ret = ret && !v
                }
                
                if ret, let v = try isDark(row: row , col: col + 6) {
                    ret = ret && v
                }
                
                if ret {
                    lostPoint += 40
                }
            }
        }

        for col in 0..<moduleCount {
            for row in 0..<moduleCount - 6 {
                guard var ret = try isDark(row: row, col: col) else {
                    continue
                }

                if ret, let v = try isDark(row: row + 1, col: col) {
                    ret = ret && !v
                }

                if ret, let v = try isDark(row: row + 2, col: col) {
                    ret = ret && v
                }

                if ret, let v = try isDark(row: row + 3, col: col) {
                    ret = ret && v
                }

                if ret, let v = try isDark(row: row + 4, col: col) {
                    ret = ret && v
                }

                if ret, let v = try isDark(row: row + 5, col: col) {
                    ret = ret && !v
                }

                if ret, let v = try isDark(row: row + 6 , col: col) {
                    ret = ret && v
                }

                if ret {
                    lostPoint += 40
                }
            }
        }
        
        // LEVEL4
        var darkCount = 0
        for col in 0..<moduleCount {
            for row in 0..<moduleCount where try isDark(row: row, col: col) == true {
                darkCount += 1
            }
        }
        
        let ratio = abs(Float(100 * darkCount) / Float(moduleCount) / Float(moduleCount) - 50) / 5
        
        lostPoint += Int(ratio) * 10
        
        return lostPoint
    }
}

fileprivate extension QRCode {
    
    enum QRCreateDataError: CustomNSError {
        static var errorDomain: String {
            return "com.daubert.qrCode.createData"
        }
        
        case createData(Int, Int)
        
        var errorCode: Int {
            return -101
        }
        
        var errorUserInfo: [String : Any] {
            switch self {
            case .createData(let length, let totalDataCount):
                return [NSLocalizedDescriptionKey: "code length overflow. (\(length) > \(totalDataCount * 8))"]
            }
        }
    }
    
    class func createData(type: Int, errorCorrecLevel: QRErrorCorrectLevel, dataList: [QR8BitByte]) throws -> [Int] {
        let rsBlocks = errorCorrecLevel.rsBlocks(type: type)
        var buffer = QRBitBuffer()
        
        for data in dataList {
            buffer.put(num: data.mode.value, length: 4)
            buffer.put(num: data.length, length: try data.mode.getLengthInBits(type: type))
            data.write(buffer: &buffer)
        }
    
        // calc num max data.
        var totalDataCount = 0
        rsBlocks.forEach { totalDataCount += $0.dataCount }
        
        guard buffer.length <= totalDataCount * 8 else {
            throw QRCreateDataError.createData(buffer.length, totalDataCount)
        }
        
        // end code
        if buffer.length + 4 <= totalDataCount * 8 {
            buffer.put(num: 0, length: 4)
        }
        
        // padding
        while buffer.length % 8 != 0 {
            buffer.put(bit: false)
        }
        
        // padding
        while true {
            guard buffer.length < totalDataCount * 8 else {
                break
            }
            
            buffer.put(num: QRCode.PAD0, length: 8)
            
            guard buffer.length < totalDataCount * 8 else {
                break
            }
            
            buffer.put(num: QRCode.PAD1, length: 8)
        }
        
        return try createBytes(buffer: buffer, rsBlocks: rsBlocks)
    }
    
    class func createBytes(buffer: QRBitBuffer, rsBlocks:[QRRSBlock]) throws -> [Int] {
        var offset = 0
        
        var maxDcCount = 0
        var maxEcCount = 0
        
        var dcdata = [[Int]](repeating: [Int](), count: rsBlocks.count)
        var ecdata = [[Int]](repeating: [Int](), count: rsBlocks.count)
        
        for r in 0..<rsBlocks.count {
            let dcCount = rsBlocks[r].dataCount
            let ecCount = rsBlocks[r].totalCount - dcCount
            
            maxDcCount = max(maxDcCount, dcCount)
            maxEcCount = max(maxEcCount, ecCount)
            
            dcdata[r] = [Int](repeating: 0, count: dcCount)
            for i in 0..<dcdata[r].count {
                dcdata[r][i] = 0xff & Int(buffer.buffer[i + offset])
            }
            offset += dcCount
            
            let rsPoly = try QRPolynomial.errorCorrectPolynomial(by: ecCount)
            let rawPoly = QRPolynomial(num: dcdata[r], shift: rsPoly.length - 1)
            
            let modPoly = try rawPoly.mod(rsPoly)
            ecdata[r] = [Int](repeating: 0, count: rsPoly.length - 1)
            for x in 0..<ecdata[r].count {
                let modIndex = x + modPoly.length - ecdata[r].count
                ecdata[r][x] = modIndex >= 0 ? modPoly[modIndex] : 0
            }
        }
        
        var totalCodeCount = 0
        for y in 0..<rsBlocks.count {
            totalCodeCount += rsBlocks[y].totalCount
        }
        
        var data = [Int](repeating: 0, count: totalCodeCount)
        var index = 0
        
        for z in 0..<maxDcCount {
            for s in 0..<rsBlocks.count where z < dcdata[s].count {
                data[index] = dcdata[s][z]
                index += 1
            }
        }
        
        for xx in 0..<maxEcCount {
            for t in 0..<rsBlocks.count where xx < ecdata[t].count {
                data[index] = ecdata[t][xx]
                index += 1
            }
        }
        
        return data
    }
}
