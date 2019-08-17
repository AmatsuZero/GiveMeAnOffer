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


struct WeiboGeo: Codable {
    /// 经度坐标
    let longitude: String
    /// 维度坐标
    let latitude: String
    /// 所在城市的城市代码
    let city: String
    /// 所在省份的省份代码
    let province: String
    /// 所在城市的城市名称
    let city_name: String
    /// 所在省份的省份名称
    let province_name: String
    /// 地址的汉语拼音，不是所有情况都会返回该字段
    let address: String?
    /// 更多信息，不是所有情况都会返回该字段
    let more: String?
}

class WeiboStatus: Codable {
    /// 微博创建时间
    let create_at: Date
    ///  微博ID
    let id: String
    ///  微博MID
    let mid: String
    /// 字符串型的微博ID
    let idstr: String
    /// 微博信息内容
    let text: String
    /// 微博来源
    let source:String
    /// 是否已收藏，true：是，false：否
    let favorited: Bool
    /// 是否被截断，true：是，false：否
    let truncated: Bool
    /// （暂未支持）回复ID
    let in_reply_to_status_id: String
    /// （暂未支持）回复人UID
    let in_reply_to_user_id: String
    /// （暂未支持）回复人昵称
    let in_reply_to_screen_name: String
    /// 缩略图片地址，没有时不返回此字段
    let thumbnail_pic: String?
    /// 中等尺寸图片地址，没有时不返回此字段
    let bmiddle_pic: String?
    /// 原始图片地址，没有时不返回此字段
    let original_pic: String?
    /// 地理信息字段
    let geo: WeiboGeo
    /// 微博作者的用户信息字段
    let user: WeiboUser
    /// 被转发的原微博信息字段，当该微博为转发微博时返回
    let retweeted_status: Int
    /// 转发数
    let reposts_count: Int
    ///  评论数
    let comments_count: Int
    /// 表态数
    let attitudes_count: Int
    /// 暂未支持
    let mlevel: Int
    
    struct Visible: Codable {
        /// 微博的可见性
        ///
        /// - common: 普通微博
        /// - personal: 私密微博
        /// - group: 指定分组微博
        /// - closeFriends: 密友微博
        enum VisibleType: Int, Codable {
            case common = 0, personal, group, closeFriends
        }
        /// 分组的组号
        let list_id: Int
    }
    /// 微博的可见性及指定可见分组信息
    let visible: Visible
    /// 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    let pic_ids: [String]?
    /// 微博流内的推广微博ID
    let ad: [String]?
}

class WeiboUser: Codable {
    /// 用户UID
    let id: Int
    /// 字符串型的用户UID
    let idstr: String
    /// 用户昵称
    let screen_name: String
    /// 友好显示名称
    let name: String
    /// 用户所在省级ID
    let province: Int
    /// 用户所在城市ID
    let city: Int
    /// 用户所在地
    let location: String
    /// 用户个人描述
    let description: String
    /// 用户博客地址
    let url: String
    /// 用户头像地址（中图），50×50像素
    let profile_image_url: String
    /// 用户的微博统一URL地址
    let profile_url: String
    /// 用户的个性化域名
    let domain: String
    /// 用户的微号
    let weihao: String
    
    /// 性别
    ///
    /// - male: 男
    /// - female: 女
    /// - unknown: 未知
    enum Gender: String, Codable {
        case male = "m"
        case female = "f"
        case unknown = "n"
    }
    /// 性别
    let gender: Gender
    /// 粉丝数
    let followers_count: Int
    /// 关注数
    let friends_count: Int
    /// 微博数
    let statuses_count: Int
    ///  收藏数
    let favourites_count: Int
    /// 用户创建（注册）时间
    let created_at: Date
    /// 暂未支持
    let following: Bool
    /// 是否允许所有人给我发私信，true：是，false：否
    let allow_all_act_msg: Bool
    /// 是否允许标识用户的地理位置，true：是，false：否
    let geo_enabled: Bool
    /// 是否是微博认证用户，即加V用户，true：是，false：否
    let verified: Bool
    /// 暂未支持
    let verified_type: Int
    /// 用户备注信息，只有在查询用户关系时才返回此字段
    let remark: String?
    /// 用户的最近一条微博信息字段
    let status: WeiboStatus?
    /// 是否允许所有人对我的微博进行评论，true：是，false：否
    let allow_all_comment: Bool
    /// 用户头像地址（大图），180×180像素
    let avatar_large: String
    /// 用户头像地址（高清），高清头像原图
    let avatar_hd: String
    /// 认证原因
    let verified_reason: String
    /// 该用户是否关注当前登录用户，true：是，false：否
    let follow_me: Bool
    
    ///  用户的在线状态
    ///
    /// - offline: 不在线
    /// - online: 在线
    enum OnlineStatus: Int, Codable {
        case offline = 0, online
    }
    /// 用户的在线状态
    let online_status: OnlineStatus
    /// 用户的互粉数
    let bi_followers_count: Int
    
    /// 用户当前的语言版本
    ///
    /// - chinese: 简体中文
    /// - traditionalChinese: 繁体中文
    /// - english: 英文
    enum Language: String, Codable {
        case chinese = "zh-cn"
        case traditionalChinese = "zh-tw"
        case english = "en"
    }
    /// 用户当前的语言版本
    let lang: Language
}
