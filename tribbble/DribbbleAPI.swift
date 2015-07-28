//
//  DribbbleAPI.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/28/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation

class DribbbleAPI {
    internal var baseURL: NSURL { return NSURL(string: "https://api.dribbble.com/v1")! }
    let tokenURL: NSURL = NSURL(string: "https://dribbble.com/oauth/token")!

    let client_id: String = NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleClientID") as! String
    let client_secret: String = NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleSecret") as! String
    let redirect_uri: String = "tribbble://oauth-code"
    
    internal var access_token: String {
        let login: Bool = false
        if login {
            // Get access token from Keychain
            return "should-get-token-from-Keychain"
        } else {
            // Get access token from Info.plist
            return NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleAccessToken") as! String
        }
    }

    // Get token
    func getToken(code: String)->Void {
        
        
        //        var params: [String: AnyObject?] = [
        //            "client_id": NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleClientID")!,
        //            "client_secret": NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleSecret")!,
        //            "code": code,
        //            "redirect_uri": "tribbble://oauth-token"
        //        ]
        
        let params = "client_id=\(client_id)&client_secret=\(client_secret)&code=\(code)&redirect_uri=\(redirect_uri)"

        let request = NSMutableURLRequest(URL: tokenURL)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = params.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)

        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let parsedData: [String: AnyObject]!
            do {
                parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions()) as! [String : AnyObject]
            } catch _ {
                parsedData = nil
            }
            
            let httpResp = response as! NSHTTPURLResponse
            
            if (error == nil ) {
                print("Success")
                
            } else {
                if (parsedData != nil){
                    guard let error_type: String = (parsedData["error"] as! String) else { "Can't get Error Type" }
                    guard let error_info: String = (parsedData["error_description"] as! String) else { "Can't get Error Description" }
                    print("Status Code:\(httpResp.statusCode)\nError Type:\(error_type)\nError Info:\(error_info)")
                } else {
                    print("Status Code:\(httpResp.statusCode)\n")
                }
            }
        }.resume()
    }
}