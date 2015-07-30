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
        if((Auth.getToken()?.isEmpty) != true) {
            return true
        } else {
            return false
        }
    }
    
    class func setToken(token: String) -> Void {
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.mySetObject(token, forKey: kSecValueData)
        keychainWrapper.writeToKeychain()
    }
    
    class func getToken() -> String? {
        let keychainWrapper = KeychainWrapper()
        return keychainWrapper.myObjectForKey("v_Data") as? String
    }
    
    class func logout() -> Void {
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.mySetObject("", forKey: kSecValueData)
        keychainWrapper.writeToKeychain()
    }
}