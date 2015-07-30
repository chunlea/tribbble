//
//  DribbbleAPI.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/28/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation
import UIKit

class DribbbleAPI {
    let baseURL: String = "https://api.dribbble.com/v1"
    let tokenURL: NSURL = NSURL(string: "https://dribbble.com/oauth/token")!

    let client_id: String = NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleClientID") as! String
    let client_secret: String = NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleSecret") as! String
    let redirect_uri: String = "tribbble://oauth-code"
    
    internal var access_token: String {
        if Auth.logged() {
            // Get access token from Keychain
            return Auth.getToken()!
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
                if (parsedData != nil){
                    guard let tokenStr: String = (parsedData["access_token"] as! String) else { "BadToken" }
                    print(tokenStr)
                    print(Auth.setToken(tokenStr))
                    print(Auth.getToken())
                } else {
                    print("Status Code:\(httpResp.statusCode)\n")
                }
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
    
    func getShots(page: Int=1, callback: (result: [DribbbleShot], error: String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL + "/shots" + "?page=\(page)")!)
        var result: [DribbbleShot] = []
        request.HTTPMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let parsedData: [AnyObject]!
      
            if data != nil {
                do {
                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions()) as! [AnyObject]
                } catch _ {
                    parsedData = nil
                }
            } else {
                parsedData = nil
            }
            
            if (error == nil ) {
                let httpResp = response as! NSHTTPURLResponse

                if (parsedData != nil){
                    for shot in parsedData {
                        result.append(DribbbleShot(json:shot as! NSDictionary))
                    }
                } else {
                    print("Status Code:\(httpResp.statusCode)\n")
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callback(result: result, error: nil)
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    callback(result: result, error: "Error!")
                })
            }

            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }.resume()
    }

    func getCommentsByShot(shot: DribbbleShot, callback: (result: [DribbbleComment], error: String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL + "/shots/" + String(shot.id) + "/comments")!)
        var result: [DribbbleComment] = []
        request.HTTPMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let parsedData: [AnyObject]!
            if data != nil {
                do {
                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions()) as! [AnyObject]
                } catch _ {
                    parsedData = nil
                }
            } else {
                parsedData = nil
            }
            
            let httpResp = response as! NSHTTPURLResponse
            
            if (error == nil ) {
                if (parsedData != nil){
                    for shot in parsedData {
                        result.append(DribbbleComment(json:shot as! NSDictionary))
                    }
                } else {
                    print("Status Code:\(httpResp.statusCode)\n")
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callback(result: result, error: nil)
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    callback(result: result, error: "Error!")
                })
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }.resume()
    }

}

