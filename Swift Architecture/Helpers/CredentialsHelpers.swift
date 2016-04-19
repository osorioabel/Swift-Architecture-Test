//
//  CredentialsHelpers.swift
//  Avail
//
//  Created by Rene De Valery on 4/18/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation
import KeychainAccess

struct CredentialsHelper {
    
    static let authorizationIdentifier = "AuthorizationCredentials"
    private static let serviceName = "UserCredentials"
    private static let keychain = Keychain(service: serviceName)
    
    static func storeCredentials(userCredentials: UserCredentials, credentialsIdentifier: String) -> Bool {
        let data = NSKeyedArchiver.archivedDataWithRootObject(userCredentials)
        
        do {
            try keychain.set(data, key: credentialsIdentifier)
            return true
        } catch {
            return false
        }
    }
    
    static func loadCredentialsWithIdentifier(credentialsIdentifier: String) -> UserCredentials? {
        var credentialData: NSData?
        
        do {
            credentialData = try keychain.getData(credentialsIdentifier)
            
            if let credentialData = credentialData {
                let credential = NSKeyedUnarchiver.unarchiveObjectWithData(credentialData) as? UserCredentials
                
                return credential
            }
        } catch {
            return nil
        }
        
        return nil
    }
    
    static func deleteCredentialWithIdentifier(identifier:String) -> Bool {
        do {
            try keychain.remove(identifier)
            return true
        } catch {
            return false
        }
    }
}
