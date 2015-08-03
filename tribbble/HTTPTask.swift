//
//  HTTPTask.swift
//  tribbble
//
//  Created by Chunlea Ju on 8/3/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class HTTPTask {
    static let shared = HTTPTask()
    static var networkFetchingCount = 0
    

    
    static func beginNetworkActivity() -> Void {
        networkFetchingCount += 1
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    static func endNetworkActivity() -> Void {
        networkFetchingCount -= 1
        if networkFetchingCount == 0 {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    func requestURL(method: HTTPMethod = .GET, url: NSURL, parameters: Dictionary<String,AnyObject>? = nil, headers: Dictionary<String,String>? = nil, completion: (NSData?, NSURLResponse?, NSError?)->Void) {
        let new_request = NSMutableURLRequest(URL: url)
        
        request(method, request: new_request, parameters: parameters, headers: headers) { (data, response, error) -> Void in
            completion(data, response, error)
        }
    
    }
    
    func request(method: HTTPMethod = .GET, request: NSMutableURLRequest, parameters: Dictionary<String,AnyObject>? = nil, headers: Dictionary<String,String>? = nil, completion: (NSData?, NSURLResponse?, NSError?)->Void) {
        request.HTTPMethod = method.rawValue
        if parameters != nil {
            let queryStr = buildQueryStr(parameters!)
            switch method{
            case .GET:
                request.URL = NSURL(string: request.URL!.absoluteString +  "?" + queryStr )
            case .POST:
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = queryStr.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
            }
        }
        
        request.setValue("Bearer \(DribbbleAPI.shared.access_token)", forHTTPHeaderField: "Authorization")
        
        if let headerItems = headers {
            for (header_key, header_value) in headerItems {
                request.setValue(header_value, forHTTPHeaderField: header_key)
            }
        }
        
        _startRequest(request, parameters: parameters) { (data, response, error)-> Void in
            completion(data, response, error)
        }
    }
    
    private func _startRequest(request: NSURLRequest, parameters: Dictionary<String,AnyObject>? = nil, completion: (NSData?, NSURLResponse?, NSError?)->Void) {
        HTTPTask.beginNetworkActivity()

        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            completion(data, response, error)
            
            HTTPTask.endNetworkActivity()
        }.resume()
    }
    
    func buildQueryStr(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in parameters.keys {
            let value: AnyObject! = parameters[key]
            components += queryComponents(key, value)
        }
        return "&".join(components.map { "\($0)=\($1)" })
    }

    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)[]", value)
            }
        } else {
            if let escape_key = "\(key)".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()), escape_value = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) {
            components.append((escape_key, escape_value))
            }
        }
        return components
    }
}