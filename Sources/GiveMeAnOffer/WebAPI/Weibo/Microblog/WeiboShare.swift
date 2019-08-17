//
//  WeiboShare.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/17.
//

import Foundation

/// 第三方分享一条链接到微博
struct WeiboShare {
    /// 采用OAuth授权方式为必填参数，OAuth授权后获得。
    let accessToken: String
    /// 用户分享到微博的文本内容，必须做URLencode，内容不超过140个汉字，文本中不能包含“#话题词#”，同时文本中必须包含至少一个第三方分享到微博的网页URL，且该URL只能是该第三方（调用方）绑定域下的URL链接，绑定域在“我的应用 － 应用信息 － 基本应用信息编辑 － 安全域名”里设置。
    let status: String
    /// 用户想要分享到微博的图片，仅支持JPEG、GIF、PNG图片，上传图片大小限制为<5M。上传图片时，POST方式提交请求，需要采用multipart/form-data编码方式。
    var picPath: String? = nil
    /// 开发者上报的操作用户真实IP，形如：211.156.0.1。
    var rip: String? = nil
}

extension WeiboShare {
    
    enum ImageDataError: CustomNSError {
        case invalidFormat
        case oversize
        
        var errorUserInfo: [String : Any] {
            switch self {
            case .invalidFormat:
                return [localizedDescription: "仅支持JPEG、GIF、PNG图片"]
            case .oversize:
                return [localizedDescription: "图片大小限制为<5M"]
            }
        }
    }
}

extension WeiboShare: WebAPIRequestProtocol  {
    
    typealias ResponseType = WeiboStatus
    
    var method: WebAPIRequestMethod {
        return .POST
    }
    
    var path: String {
        return "statuses/share"
    }
    
    static var baseURL: URL? {
        return WeiboAPI.baseURL
    }
    
    var params: [String : Any] {
        return [
            "access_token": accessToken,
            "status": status,
            "rip": rip ?? ""
        ]
    }
    
    func asRequest() throws -> URLRequest {
        let url = try asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = try createBody(boundary: boundary)
        return request
    }
    
    func createBody(boundary: String,
                    mimeType: String = "image/jpg") throws -> Data? {
        
        guard let path = picPath else {
            return nil
        }
        
        var body = Data()
        let url = URL(fileURLWithPath: path)
        
        /// 仅支持JPEG、GIF、PNG图片
        let validExts = ["jpg", "png", "gif", "jpeg"]
        
        guard !validExts.contains(url.pathExtension) else {
            throw ImageDataError.invalidFormat
        }
        
        let data = try Data(contentsOf: url)
        
        // 上传图片大小限制为<5M
        guard data.count < 1024 * 1024 * 5 else {
            throw ImageDataError.oversize
        }
        
       
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in params {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(url.lastPathComponent)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body
    }
}

