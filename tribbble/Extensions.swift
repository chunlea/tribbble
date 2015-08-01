//
//  Extensions.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/31/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            
            let request = NSMutableURLRequest(URL: url)

            if let cachedRequest = NSURLCache().cachedResponseForRequest(request) {
                self.image = UIImage(data: cachedRequest.data)
            } else {
                NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.image = UIImage(data: data!)
                    }
                }.resume()
            }
        }
    }
}