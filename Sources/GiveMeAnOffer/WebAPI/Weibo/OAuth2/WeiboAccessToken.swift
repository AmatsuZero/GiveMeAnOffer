//
//  WeiboAccessToken.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/11.
//

import Foundation

struct WeiboRawToken {
    /// 用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
    public let token: String
    /// 生命周期，单位是秒数。
    let expiresIn: TimeInterval
    /// 授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。
    let uid: String
}

extension WeiboRawToken: Codable {
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case uid
        case expiresIn = "expires_in"
    }
}

// 必须继承自NSObject，否则归解档会不正常：https://stackoverflow.com/questions/25805599/got-unrecognized-selector-replacementobjectforkeyedarchiver-crash-when-impleme
public class WeiBoStoredAccessToken: NSObject {
    /// 过期时间
    @objc public let expireDate: Date?
    /// 用户授权的唯一票据
    @objc public let accessToken: String?
    
    var isValid: Bool {
        return expireDate != nil && expireDate! > Date()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        expireDate = aDecoder.decodeObject(forKey: NSStringFromSelector(#selector(getter: expireDate))) as? Date
        accessToken = aDecoder.decodeObject(forKey: NSStringFromSelector((#selector(getter: accessToken)))) as? String
    }
    
    init(rawToken: WeiboRawToken) {
        self.accessToken = rawToken.token
        self.expireDate = Date(timeIntervalSinceNow: rawToken.expiresIn)
    }
}

extension WeiBoStoredAccessToken: NSSecureCoding {
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(expireDate, forKey: NSStringFromSelector(#selector(getter: expireDate)))
        aCoder.encode(accessToken, forKey: NSStringFromSelector(#selector(getter: accessToken)))
    }
}

struct WeiboAccessToken {
    /// 申请应用时分配的AppKey。
    let clientID = WeiboAPI.shared.clientId
    /// 申请应用时分配的AppSecret。
    let clientSecret = WeiboAPI.shared.clientSecret
    /// 请求的类型，填写authorization_code
    let grantType = "authorization_code"
    /// 回调地址，需需与注册应用里的回调地址一致。
    let redirectURL = WeiboAPI.shared.redirectURL
    ///  调用authorize获得的code值。
    let code: String
    
    static let tokenFolderPath: URL = {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent(".GiveMeAnOffer/Weibo", isDirectory: true)
        return url
    }()
    
    static let tokenPath: URL = {
        return tokenFolderPath.appendingPathComponent("accesstoken")
    }()
    
    public init(code: String) {
        self.code = code
    }
    
    @discardableResult
    func request(_ handler: @escaping (Error?, WeiBoStoredAccessToken?) -> Void) throws -> URLSessionDataTask {
        let task = WeiboAPI.shared.session.dataTask(with: try asRequest()) { (data, _, error) in
            guard error == nil, let data = data else {
                handler(error, nil)
                return
            }
            do {
                let raw = try JSONDecoder().decode(WeiboRawToken.self, from: data)
                let token = WeiBoStoredAccessToken(rawToken: raw)
                NSKeyedArchiver.archiveRootObject(token, toFile: WeiboAccessToken.tokenPath.path)
                handler(nil, token)
            } catch let e {
                handler(e, nil)
            }
        }
        return task
    }
}

extension WeiboAccessToken: WebAPIRequestProtocol {
    var path: String {
        return "oauth2/access_token"
    }
    
    static var baseURL: URL? {
        return WeiboAPI.baseURL
    }
    
    func asURLComponents() throws -> URLComponents {
        let url = try asURL()
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw WebAPIError.invalidURL
        }
        
        var queryItems = [URLQueryItem]()
        queryItems.append(.init(name: "client_id", value: clientID))
        queryItems.append(.init(name: "client_secret", value: clientSecret))
        queryItems.append(.init(name: "grant_type", value: grantType))
        queryItems.append(.init(name: "redirect_uri", value: redirectURL))
        queryItems.append(.init(name: "code", value: code))
        components.queryItems = queryItems
        
        return components
    }
    
    typealias ResponseType = WeiboAccessToken
    
    var method: WebAPIRequestMethod {
        return .POST
    }
}
