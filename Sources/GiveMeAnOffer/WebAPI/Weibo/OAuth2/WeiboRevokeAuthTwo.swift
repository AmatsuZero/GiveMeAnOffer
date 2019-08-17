//
//  WeiboRevokeAuthTwo.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/13.
//

import Foundation

/// 授权回收接口，帮助开发者主动取消用户的授权。
/*
 1. 应用下线时，清空所有用户的授权
 2. 应用新上线了功能，需要取得用户scope权限，可以回收后重新引导用户授权
 3. 开发者调试应用，需要反复调试授权功能
 4. 应用内实现类似登出微博帐号的功能
 */
struct WeiboRevokeAuthTwo {
    /// 用户授权应用的access_token
    let accessToken: String
    
    @discardableResult
    func request(handler: @escaping (Error?, WeiboRevokeAuthResponse?) -> Void) -> URLSessionDataTask? {
        var task: URLSessionDataTask?
        do {
            task = WeiboAPI.shared.session.dataTask(with: try asRequest()) { (data, _, error) in
                guard error == nil, let data = data else {
                    handler(error, nil)
                    return
                }
                do {
                    let raw = try JSONDecoder().decode(WeiboRevokeAuthResponse.self, from: data)
                    handler(nil, raw)
                } catch let e {
                    handler(e, nil)
                }
            }
            
        } catch {
            handler(error, nil)
        }
        return task
    }
}

public struct WeiboRevokeAuthResponse: Codable {
    let result: Bool
}

extension WeiboRevokeAuthTwo: WebAPIRequestProtocol {
    
    var path: String {
        return "oauth2/revokeoauth2"
    }
    
    static var baseURL: URL? {
        return WeiboAPI.baseURL
    }
    
    typealias ResponseType = WeiboRevokeAuthResponse
    
    var params: [String : Any] {
        return ["access_token": accessToken]
    }
}
