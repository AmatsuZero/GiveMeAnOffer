//
//  WeiboGetTokenInfo.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/12.
//

import Foundation

struct WeiboTokenInfo {
    /// 授权用户的uid。
    let uid: Int
    ///  access_token所属的应用appkey
    let appkey: String
    /// 用户授权的scope权限。
    let scope: String?
    /// access_token的创建时间，从1970年到创建时间的秒数。
    let createAt: TimeInterval
    ///  access_token的剩余时间，单位是秒数
    let expireIn: TimeInterval
}

extension WeiboTokenInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case appkey
        case uid
        case scope
        case expireIn = "expire_in"
        case createAt = "create_at"
    }
}

/// 查询用户access_token的授权相关信息，包括授权时间，过期时间和scope权限。
struct WeiboGetTokenInfo {
    /// 用户授权时生成的access_token
    let accessToken: String
    
    @discardableResult
    func request(_ handler: @escaping (Error?, WeiBoStoredAccessToken?) -> Void) throws -> URLSessionDataTask {
        let accessToken = self.accessToken
        let task = WeiboAPI.shared.session.dataTask(with: try asRequest()) { (data, _, error) in
            guard error == nil, let data = data else {
                handler(error, nil)
                return
            }
            do {
                let raw = try JSONDecoder().decode(WeiboTokenInfo.self, from: data)
                let token = WeiBoStoredAccessToken(accessToken: accessToken, tokenInfo: raw)
                handler(nil, token)
            } catch let e {
                handler(e, nil)
            }
        }
        return task
    }
}

extension WeiboGetTokenInfo: WebAPIRequestProtocol {
    
    typealias ResponseType = WeiBoStoredAccessToken
    
    var path: String {
        return "oauth2/get_token_info"
    }
    
    static var baseURL: URL? {
        return WeiboAPI.baseURL
    }
    
    var method: WebAPIRequestMethod {
        return .POST
    }
    
    func asURLComponents() throws -> URLComponents {
        let url = try asURL()
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw WebAPIError.invalidURL
        }
        
        var queryItems = [URLQueryItem]()
        queryItems.append(.init(name: "access_token", value: accessToken))
        components.queryItems = queryItems
        return components
    }
}
