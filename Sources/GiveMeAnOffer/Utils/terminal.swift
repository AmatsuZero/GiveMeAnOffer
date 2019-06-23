//
// Created by daubert on 19-6-13.
//

import Foundation

@discardableResult
@available(iOS, unavailable)
func shell(_ args: String...) -> (code: Int32, output: String?) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()

    let pipe = Pipe()
    task.standardOutput = pipe
    
    if #available(OSX 10.13, *) {
        try? task.run()
    } else {
        task.launch()
    }

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)

    return (task.terminationStatus, output)
}
