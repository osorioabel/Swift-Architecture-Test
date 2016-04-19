//
//  AuthenticationService.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import Alamofire

struct AuthenticationService {
    
    enum Key: String {
        case GrantType = "grant_type"
        case Client = "client_id"
        case ClientSecret = "client_secret"
        case Username = "username"
        case Password = "password"
    }
    
    func getAccessTokenWithUsername(username: String, password: String, completion: ((result: Result<UserCredentials, APIError>) -> Void)?) {
        var parameters = [String: String]()
        
        parameters[Key.GrantType.value] = "password"
        parameters[Key.Client.value] = "1"
        parameters[Key.ClientSecret.value] = "LLjL[l43h2FANW/hF5[}Tks%Ywd5?[mG"
        parameters[Key.Username.value] = username
        parameters[Key.Password.value] = password
        
        Alamofire.request(Router.AccessToken(parameters)).validate().responseJSON { (response) -> Void in
            var finalResult: Result<UserCredentials, APIError>
            
            switch response.result {
            case .Success(let JSON):
                guard let JSONdictionary = JSON as? [String: AnyObject],
                    let userCredentials = UserCredentials(JSONDictionary: JSONdictionary) else {
                        print("Couldn't get a dictionary from the response: \(JSON)")
                        finalResult = Result.Failure(APIError.defaultError())
                        
                        return
                }
                
                CredentialsHelper.storeCredentials(userCredentials, credentialsIdentifier: CredentialsHelper.authorizationIdentifier)
                finalResult = Result.Success(userCredentials)
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