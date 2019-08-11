//
//  WeiboScope.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/11.
//

import Foundation

/// scope是OAuth2.0授权机制中authorize接口的一个参数。[参考链接](https://open.weibo.com/wiki/Scope)
///
/// 通过scope，平台将开放更多的微博核心功能给开发者，同时也加强用户隐私保护，提升了用户体验，用户在新OAuth2.0授权页中有权利选择赋予应用的功能。
/// - all: 请求下列所有scope权限
/// - email: 用户的联系邮箱, [接口文档](https://open.weibo.com/wiki/2/account/profile/email)
/// - directMessageWrite: 私信发送接口，[接口文档](http://open.weibo.com/wiki/C/2/direct_messages)
/// - directMessageRead: 私信读取接口，[接口文档](http://open.weibo.com/wiki/C/2/direct_messages)
/// - invitationWrite: 邀请发送接口，[接口文档](http://open.weibo.com/wiki/Messages#.E5.A5.BD.E5.8F.8B.E9.82.80.E8.AF.B7)
/// - friendshipGroupRead: 好友分组读取接口组，[接口文档](http://open.weibo.com/wiki/API%E6%96%87%E6%A1%A3_V2#.E5.A5.BD.E5.8F.8B.E5.88.86.E7.BB.84)
/// - friendsshipGroupWrite: 好友分组写入接口组，[接口文档](http://open.weibo.com/wiki/API%E6%96%87%E6%A1%A3_V2#.E5.A5.BD.E5.8F.8B.E5.88.86.E7.BB.84)
/// - statusToMeRead: 定向微博读取接口组，[接口文档](http://open.weibo.com/wiki/API%E6%96%87%E6%A1%A3_V2#.E5.BE.AE.E5.8D.9A)
/// - followAppOfficialMicroblog: 关注应用官方微博，该参数不对应具体接口，只需在应用控制台填写官方帐号即可。填写的路径：我的应用-选择自己的应用-应用信息-基本信息-官方运营账号（默认值是应用开发者帐号）
public enum WeiboScope: String {
    case all, email
    case directMessageWrite = "direct_messages_write"
    case directMessageRead = "direct_messages_read"
    case invitationWrite = "invitation_write"
    case friendshipGroupRead = "friendships_groups_read"
    case friendsshipGroupWrite = "friendships_groups_write"
    case statusToMeRead = "statuses_to_me_read"
    case followAppOfficialMicroblog = "follow_app_official_microblog"
}


/// Scope相关错误代码
///
/// - insufficientAppPermissions: 第三方应用访问api接口权限受限制
/// - accessDenied: 用户或授权服务器拒绝授予数据访问权限
enum WeiboScopeError: CustomNSError {
    case insufficientAppPermissions
    case accessDenied
    
    static var errorDomain: String {
        return "com.givemeanoffer.webapi.weibo.scope"
    }
    
    var errorCode: Int {
        switch self {
        case .insufficientAppPermissions: return 10014
        case .accessDenied: return 10032
        }
    }
    
    var errorUserInfo: [String : Any] {
        switch self {
        case .insufficientAppPermissions:
            return [
                localizedDescription: "第三方应用访问api接口权限受限制",
                NSLocalizedRecoverySuggestionErrorKey: "应用没有接口的权限，需要在应用控制台接口管理那在线申请"
            ]
        case .accessDenied:
            return [
                localizedDescription: "用户或授权服务器拒绝授予数据访问权限",
                NSLocalizedRecoverySuggestionErrorKey: "重新向用户申请scope权限"
            ]
        }
    }
}
