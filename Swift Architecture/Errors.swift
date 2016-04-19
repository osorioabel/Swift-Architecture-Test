//
//  Errors.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation

typealias APIError = Error<APIErrorCode>
typealias UserError = Error<UserErrorCode>

struct Error<ErrorCode>: ErrorType {
    
    let title: String?
    let message: String?
    let code: ErrorCode?
}

// MARK: - API Error

extension Error {
    
    static func defaultError() -> APIError {
        return APIError(title: "Error", message: "Unkown Error Occurred", code: .ErrorUnknown)
    }
    
    static func apiError(error error: NSError, data: NSData?) -> APIError {
        
        let apiErrorCode = APIErrorCode(rawValue: error.code) ?? .ErrorUnknown
        let error = APIError(title: "", message: error.localizedDescription, code: apiErrorCode)
        
        return error
    }
}

enum APIErrorCode: Int {
    case ErrorUnknown = 0
    case ErrorCodeOne = 1
    case ErrorCodeTwo = 2
}

//MARK: - User Error

extension Error {
    
    static func userError(errorCode: UserErrorCode) -> UserError {
        
        switch errorCode {
        case .InvalidEmailCode:
            return UserError(title: "Error", message: "Enter a valid email", code: errorCode)
        case .InvalidUsernameCode:
            return UserError(title: "Error", message: "Invalid username", code: errorCode)
        case .InvalidPasswordCode:
            return UserError(title: "Error", message: "Invalid password", code: errorCode)
        }
    }
}

enum UserErrorCode: Int {
    case InvalidEmailCode = 0
    case InvalidUsernameCode = 1
    case InvalidPasswordCode = 2
}

