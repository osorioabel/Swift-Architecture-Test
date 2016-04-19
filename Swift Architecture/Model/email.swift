//
//  User.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import ObjectMapper


struct User : Mappable{
    
    enum Role: Int {
        case Facilitator = 3
        case Learner = 5
    }
    
    var identifier: Int?
    var username: String?
    var role: Role?
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        identifier <- map["id"]
        username <- map["email"]
        role <- map["role"]
    }
    
    init(identifier: Int, username: String, role: Role) {
        self.identifier = identifier
        self.username = username
        self.role = role
    }
    
    static func validateUsername(username: String?, password: String?) throws {
        let validator = UserValidator()
        
        guard let username = username where validator.validateUsername(username) else {
            throw UserError.userError(.InvalidUsernameCode)
        }
        
        guard let password = password where validator.validatePassword(password) else {
            throw UserError.userError(.InvalidPasswordCode)
        }
    }
    
    static func validateEmail(email: String?, password: String?) throws {
        let validator = UserValidator()
        
        guard let email = email where validator.validateEmail(email) else {
            throw UserError.userError(.InvalidEmailCode)
        }
        
        guard let password = password where validator.validatePassword(password) else {
            throw UserError.userError(.InvalidPasswordCode)
        }
    }
}