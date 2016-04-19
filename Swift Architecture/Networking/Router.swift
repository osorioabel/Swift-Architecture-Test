//
//  Router.swift
//  Avail
//
//  Created by Rene De Valery on 4/7/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseHostPath = "http://availapi.cinnco.co"
    static let versionPath = "/v1"
    static let oauthPath = "/oauth"
    static let authenticationToken = ""
    
    var baseURLPath: String {
        
        switch self {
        case AccessToken, RefreshToken:
            return "\(Router.baseHostPath)\(Router.oauthPath)"
        default:
            return "\(Router.baseHostPath)\(Router.versionPath)"
        }
        
    }
    
    static var authorizationToken: String? {
       return ""
    }
    case AccessToken([String: AnyObject])
    case RefreshToken([String: String])
    
    case SignIn([String: String])
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, method: Alamofire.Method, parameters: [String: AnyObject]) = {
            switch self {
            case AccessToken(let parameters):
                return ("/access-token", .POST, parameters)
            case RefreshToken(let parameters):
                return ("/refresh-token", .POST, parameters)
            case SignIn(let parameters):
                return ("/user/login", .POST, parameters)
            }
        }()
        
        let URL = NSURL(string: baseURLPath)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        URLRequest.HTTPMethod = result.method.rawValue
        
        if let authorizationToken = Router.authorizationToken {
            URLRequest.setValue(authorizationToken, forHTTPHeaderField: "Authorization")
        }
        
        URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
        
        let encoding = Alamofire.ParameterEncoding.JSON
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}
