//
//  EncodingHelper.swift
//  Avail
//
//  Created by Rene De Valery on 4/13/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation

struct EncondingHelper {
    
    static func encodePassword(password: String) -> String {
        let stringToEncode = (password + ":" + md5String(password))
        
        return base64EncodedString(stringToEncode)
    }
    
    static private func md5String(string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
    static private func base64EncodedString(string: String) -> String {
        let utf8str = string.dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = utf8str!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        return base64Encoded
    }
}
