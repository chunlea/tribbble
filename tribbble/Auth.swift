//
//  Auth.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/29/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation
import Security

class Auth {
    class func logged() -> Bool {
        if(Auth.getToken() != nil) {
            return true
        } else {
            return false
        }
    }
    
    class func setToken(token: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : "token",
            kSecValueData as String   : token ]
        
        SecItemDelete(query as CFDictionaryRef)
        
        let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
        
        return status == noErr
    }
    
    class func getToken() -> String? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ]
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = withUnsafeMutablePointer(&dataTypeRef) { SecItemCopyMatching(query as CFDictionaryRef, UnsafeMutablePointer($0)) }
        
        if status == noErr {
            let result: String = NSString(data: (dataTypeRef as! NSData), encoding: NSUTF8StringEncoding) as! String
            return result
        } else {
            return nil
        }
    }
    
    class func logout() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
        
        return status == noErr
    }
}