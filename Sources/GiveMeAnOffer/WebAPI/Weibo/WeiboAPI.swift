//
//  WeiboAPI.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/11.
//

import Foundation

enum WeiboAPIError: Error {
    case authorizeFailed
    case noAccessToken
}

class WeiboAPI {
    
    public let clientId: String
    public let clientSecret: String
    public let redirectURL: String
    
    static let baseURL = URL(string: "https://api.weibo.com")
    
    public static var shared: WeiboAPI!
    
    var accessToken: WeiBoStoredAccessToken?
    
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    init(clientId: String, clientSecret: String, redirectURL: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURL = redirectURL
    }
    
    public class func register(clientId: String, clientSecret: String, redirectURL: String) throws {
        shared = WeiboAPI(clientId: clientId, clientSecret: clientSecret, redirectURL: redirectURL)
        // 检查已有Toekn
        if !FileManager.default.fileExists(atPath:  WeiboAccessToken.tokenFolderPath.path) {
            try FileManager.default.createDirectory(at: WeiboAccessToken.tokenFolderPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        // 尝试获取已有的Token, 并检查是否过期
        if FileManager.default.fileExists(atPath: WeiboAccessToken.tokenPath.path),
            let token = NSKeyedUnarchiver.unarchiveObject(withFile: WeiboAccessToken.tokenPath.path) as? WeiBoStoredAccessToken,
            token.isValid {
            shared.accessToken = token
        }
    }
    
    public func authorize(_ api: WeiboAuthorize) throws -> WeiboAuthorize.ResponseType? {
        return try api.request()
    }
    
    public func accessToken(_ authorize: WeiboAuthorize, handler: @escaping (Error?, WeiBoStoredAccessToken?) -> Void)  {
        
        guard accessToken == nil else {
            handler(nil, accessToken)
            return
        }
        do {
            guard let code = try self.authorize(authorize)?.code else {
                handler(WeiboAPIError.authorizeFailed, nil)
                return
            }
            
            let api = WeiboAccessToken(code: code)
            api.request(handler: handler)?.resume()
        } catch {
            handler(error, nil)
        }
    }
    
    public func updateToken(_ token: String, handler: ((Error?, WeiBoStoredAccessToken?) -> Void)? = nil) {
        let api = WeiboGetTokenInfo(accessToken: token)
        api.request { [weak self] (error, tokenInfo) in
            self?.accessToken = tokenInfo
            // 写入磁盘
            if let newToken = tokenInfo {
                NSKeyedArchiver.archiveRootObject(newToken, toFile: WeiboAccessToken.tokenPath.path)
            }
            handler?(error, tokenInfo)
        }?.resume()
    }
    
    public func revoke(handler: @escaping (Error?, WeiboRevokeAuthResponse?) -> Void) {
        guard let token = accessToken?.accessToken else {
            handler(WeiboAPIError.noAccessToken, nil)
            return
        }
        let api = WeiboRevokeAuthTwo(accessToken: token)
        api.request(handler: handler)?.resume()
    }
}

extension WeiboAPI {
    func importToken(_ token: String, handler: ((Error?, WeiBoStoredAccessToken?) -> Void)? = nil) {
        updateToken(token, handler: handler)
    }
}
