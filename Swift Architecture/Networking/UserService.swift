//
//  UserService.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct UserService {
    
    enum Key: String {
        case Username = "username"
        case Password = "password"
        case Platform = "platform"
        case RoleId = "role_id"
    }
    
    func signInWithUsername(username: String, password: String, role: User.Role, completion: ((result: Result<User, APIError>) -> Void)?) {
        
        let authenticationService = AuthenticationService()
        authenticationService.getAccessTokenWithUsername(username, password: password) { (result) in
            
            var parameters = [String: String]()
            let encondedPassword = EncondingHelper.encodePassword(password)
            
            parameters[Key.Username.value] = username
            parameters[Key.Password.value] = encondedPassword
            parameters[Key.Platform.value] = PlatformHelper.platform()
            parameters[Key.RoleId.value] = String(role.value)
            
            Alamofire.request(Router.SignIn(parameters)).validate().responseObject { (response: Response<User, NSError>) -> Void in
                var finalResult: Result<User, APIError>
                switch response.result {
                case .Success(let JSON):
                    let userFromResponse = response.result.value
                    if let userModel = userFromResponse {
                        finalResult = Result.Success(userModel)
                    }
                case .Failure(let error):
                    let apiError = APIError.apiError(error: error, data: response.data)
                    finalResult = Result.Failure(apiError)
                }
                
                if let completion = completion {
                    completion(result: finalResult)
                }
            }
        }
    }
}