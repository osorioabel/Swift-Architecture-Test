//
//  UserAPI.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import Alamofire

struct UserAPI {
    
    static func signInWithUsername(username: String, password: String, role: User.Role, completion: ((result: Result<User, APIError>) -> Void)?) {
        let userService = UserService()
        
        userService.signInWithUsername(username, password: password, role: role, completion: completion)
    }
}