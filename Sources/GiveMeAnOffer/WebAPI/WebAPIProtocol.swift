//
//  WebAPIProtocol.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/11.
//

import Foundation

enum WebAPIError: CustomNSError {
    case invalidURL
    
    var errorCode: Int {
        switch self {
        case .invalidURL: return 900001
        }
    }
    
    var errorUserInfo: [String : Any] {
        switch self {
        case .invalidURL:
            return [localizedDescription: "无效的URL"]
        }
    }
}

enum WebAPIRequestMethod: String {
    case GET, POST, PUT, HEAD, DELETE
}

protocol WebAPIRequestProtocol {
    
    associatedtype ResponseType
    
    var path: String { get }
    
    var method: WebAPIRequestMethod { get }
    
    static var baseURL: URL? { get }
    
    var timeout: TimeInterval { get }
    
    var params: [String: Any] { get }
    
    func asURL() throws -> URL
    
    func asRequest() throws -> URLRequest
    
    func asURLComponents() throws -> URLComponents
}

extension WebAPIRequestProtocol {
    
    
    
    func asURL() throws -> URL {
        guard let url = URL(string: path, relativeTo: WeiboAPI.baseURL) else {
            throw WebAPIError.invalidURL
        }
        return url
    }
    
    var timeout: TimeInterval { return 3 }
    
    var params: [String: Any] { return [:] }
    
    var method: WebAPIRequestMethod { return .GET }
    
    func asURLComponents() throws -> URLComponents {
        let url = try asURL()
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw WebAPIError.invalidURL
        }
        switch method {
        case .POST: break
        default:
            
            components.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
        }
        return components
    }
    
    func asRequest() throws -> URLRequest {
        let components = try self.asURLComponents()
    
        guard let url = components.url else {
            throw WebAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        
        switch method {
        case .POST where !params.isEmpty:
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        default:
            break
        }
        return request
    }
}


