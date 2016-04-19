//
//  UserCredentials.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation

class UserCredentials: NSObject, NSCoding {
    
    // MARK: - Properties
    
    enum Key: String {
        case AccessToken = "access_token"
        case RefreshToken = "refresh_token"
        case TokenType = "token_type"
    }
    
    var accessToken: String
    var refreshToken: String
    var tokenType: String
    
    var authorizationToken: String {
        return "\(tokenType) \(accessToken)"
    }
    
    // MARK: - Lifecycle
    
    init(accessToken: String, refreshToken: String, tokenType: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
    }
    
    convenience init?(JSONDictionary json: [String: AnyObject]) {
        guard let accessToken = json[Key.AccessToken.value] as? String,
            refreshToken = json[Key.RefreshToken.value] as? String,
            tokenType = json[Key.TokenType.value] as? String else {
                return nil
        }
        
        self.init(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType)
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let accessToken = aDecoder.decodeObjectForKey(Key.AccessToken.value) as? String,
            refreshToken = aDecoder.decodeObjectForKey(Key.RefreshToken.value) as? String,
            tokenType = aDecoder.decodeObjectForKey(Key.TokenType.value) as? String else {
                return nil
        }
        
        self.init(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(accessToken, forKey: Key.AccessToken.value)
        aCoder.encodeObject(refreshToken, forKey: Key.RefreshToken.value)
        aCoder.encodeObject(tokenType, forKey: Key.TokenType.value)
    }
}
