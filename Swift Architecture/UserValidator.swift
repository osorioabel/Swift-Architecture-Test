//
//  UserValidator.swift
//  Avail
//
//  Created by Rene De Valery on 4/12/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation

struct UserValidator {
    
    func validateEmail(email: String) -> Bool {
        let validator = Validator(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        
        return validator.validate(email)
    }
    
    func validateUsername(username: String) -> Bool {
        let validator = Validator(pattern: "[A-Z0-9]{1,30}")
        
        return validator.validate(username)
    }
    
    func validatePassword(password: String) -> Bool {
        let validator = Validator(pattern: "[A-Z0-9]{1,30}")
        
        return validator.validate(password)
    }
}
