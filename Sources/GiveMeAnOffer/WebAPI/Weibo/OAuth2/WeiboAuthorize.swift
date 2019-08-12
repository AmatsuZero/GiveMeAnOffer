//
//  WeiboAuthorize.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/11.
//

import Foundation

/// OAuth2的authorize接口
public struct WeiboAuthorize {
    /// 授权页面的终端类型
    ///
    /// - `default`: 默认的授权页面，适用于web浏览器。
    /// - mobile: 移动终端的授权页面，适用于支持html5的手机。注：使用此版授权页请用 https://open.weibo.cn/oauth2/authorize 授权接口
    /// - wap: wap版授权页面，适用于非智能手机。
    /// - client: 客户端版本授权页面，适用于PC桌面应用。
    /// - apponweibo: 默认的站内应用授权页，授权后不返回access_token，只刷新站内应用父框架。
    public enum DisplayType: String {
        case `default`, mobile, wap, client, apponweibo
    }
    /// 申请应用时分配的AppKey。
    let clientID = WeiboAPI.shared.clientId
    /// 授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    let redirectURL = WeiboAPI.shared.redirectURL
    /// 申请scope权限所需参数，可一次申请多个scope权限
    public var scope: Set<WeiboScope>? = nil
    /// 授权页面的终端类型
    public var display: DisplayType? = nil
    /// 是否强制用户重新登录，true：是，false：否。默认false。
    public var forcelogin: Bool?
    /// 用于保持请求和回调的状态，在回调时，会在Query Parameter中回传该参数。开发者可以用这个参数验证请求有效性，也可以记录用户请求授权页前的位置。这个参数可用于防止跨站请求伪造（CSRF）攻击
    public var state: String? = nil
    /// 授权页语言，缺省为中文简体版，en为英文版。英文版测试中，开发者任何意见可反馈至 @微博API
    public var language = ""
    
    func request() throws -> ResponseType? {
        guard let url = try asURLComponents().url?.absoluteString else {
            return nil
        }
        // 通过网页打开授权页
        #if !os(macOS)
            shell("xdg-open", url)
        #else
            shell("open", url)
        #endif

        // 输入授权后跳转的URL
        guard let tokenURL = takeInput(prompt: "输入授权后跳转的URL："),
            let components = URLComponents(string: tokenURL) else {
            return nil
        }
        
        // 找到Code
        var code: String?
        var state: String?
        components.queryItems?.forEach { item in
            switch item.name {
            case "code":
                code = item.value
            case "state":
                state = item.value
            default:
                break
            }
        }
        return (code, state)
    }
}

extension WeiboAuthorize: WebAPIRequestProtocol {
    
    typealias ResponseType = (code: String?, state: String?)
    
    var path: String {
        return "oauth2/authorize"
    }
    
    static var baseURL: URL? {
        return WeiboAPI.baseURL
    }
    
    var params: [String : Any] {
        
        var params: [String: Any] = [
            "client_id": clientID,
            "redirect_uri": redirectURL,
        ]
        
        if let forceLogin = self.forcelogin {
            params["forcelogin"] = forceLogin
        }
        
        if let scopes = self.scope {
            params["scope"] = scopes
                .map { $0.rawValue }
                .joined(separator: ",")
        }
        if let display = self.display {
            params["display"] = display.rawValue
        }
        
        if !language.isEmpty {
            params["language"] = language
        }
        
        if let state = self.state {
            params["state"] = state
        }
        
        return params
    }
}
