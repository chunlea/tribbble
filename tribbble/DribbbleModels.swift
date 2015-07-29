//
//  DribbbleModels.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/29/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation

class DribbbleBucket: NSObject {
     var id: Int
     var name: String
     var descriptions: String
     var shots_count: Int
     var created_at: NSDate
     var updated_at: NSDate
     var user: DribbbleUser?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString(json["created_at"] as! String)!
        updated_at = dateFor.dateFromString(json["updated_at"] as! String)!
        
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        descriptions = json["description"] as? String ?? ""
        shots_count = json["shots_count"] as? Int ?? 0
        
        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleUser(json: json["user"] as! NSDictionary)
        }

    }
}

class DribbbleProject: NSObject {
     var id: Int
     var name: String
     var descriptions: String
     var shots_count: Int
     var created_at: NSDate
     var updated_at: NSDate
     var user: DribbbleUser?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString(json["created_at"] as! String)!
        updated_at = dateFor.dateFromString(json["updated_at"] as! String)!
        
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        descriptions = json["descriptions"] as? String ?? ""
        shots_count = json["shots_count"] as? Int ?? 0

        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleTeam(json: json["user"] as! NSDictionary)
        }

    }
}

class DribbbleShot: NSObject {
     var id: Int
     var title: String
     var descriptions: String
     var width: Int
     var height: Int
     var images: [String: String] = [
        "hidpi": "",
        "normal": "",
        "teaser": ""
    ]
     var views_count: Int
     var likes_count: Int
     var comments_count: Int
     var attachments_count: Int
     var rebounds_count: Int
     var buckets_count: Int
     var html_url: String
     var attachments_url: String
     var buckets_url: String
     var comments_url: String
     var likes_url: String
     var projects_url: String
     var rebounds_url: String
     var tags: [String] = []
     var user: DribbbleUser?
     var team: DribbbleTeam?
     var created_at: NSDate
     var updated_at: NSDate
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString(json["created_at"] as! String)!
        updated_at = dateFor.dateFromString(json["updated_at"] as! String)!
        
        id = json["id"] as! Int ?? 0
        title = json["title"] as! String
        descriptions = json["descriptions"] as? String ?? ""
        width = json["width"] as? Int ?? 0
        height = json["height"] as? Int ?? 0
        images["hidpi"] = (json["images"] as! NSDictionary)["hidpi"] as? String ?? ""
        images["normal"] = (json["images"] as! NSDictionary)["normal"] as? String ?? ""
        images["teaser"] = (json["images"] as! NSDictionary)["teaser"] as? String ?? ""
        views_count = json["views_count"] as? Int ?? 0
        likes_count = json["likes_count"] as? Int ?? 0
        comments_count = json["comments_count"] as? Int ?? 0
        attachments_count = json["attachments_count"] as? Int ?? 0
        rebounds_count = json["rebounds_count"] as? Int ?? 0
        buckets_count = json["buckets_count"] as? Int ?? 0
        html_url = json["html_url"] as? String ?? ""
        attachments_url = json["attachments_url"] as? String ?? ""
        buckets_url = json["buckets_url"] as? String ?? ""
        comments_url = json["comments_url"] as? String ?? ""
        likes_url = json["likes_url"] as? String ?? ""
        projects_url = json["projects_url"] as? String ?? ""
        rebounds_url = json["rebounds_url"] as? String ?? ""
        tags = json["tags"] as? [String] ?? []

        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleUser(json: json["user"] as! NSDictionary)
        }
        
        if json["team"]!.isKindOfClass(NSDictionary) {
            team = DribbbleTeam(json: json["team"] as! NSDictionary)
        }
        
        
    }
}

class DribbbleAttachment: NSObject {
     var id: Int
     var url: String
     var thumbnail_url: String
     var size: Int
     var content_type: String
     var views_count: Int
     var created_at: NSDate
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString(json["created_at"] as! String)!

        id = json["id"] as? Int ?? 0
        url = json["url"] as? String ?? ""
        thumbnail_url = json["thumbnail_url"] as? String ?? ""
        size = json["size"] as? Int ?? 0
        content_type = json["content_type"] as? String ?? ""
        views_count = json["views_count"] as? Int ?? 0
    }
}

class DribbbleUser: NSObject {
     var id: Int
     var name: String
     var username: String
     var html_url: String
     var avatar_url: String
     var bio : String
     var location: String
     var links: [String: String] = [
        "web": "",
        "twitter" : ""
    ]
     var buckets_count: Int
     var comments_received_count: Int
     var followers_count: Int
     var followings_count: Int
     var likes_count: Int
     var likes_received_count: Int
     var projects_count: Int
     var rebounds_received_count: Int
     var shots_count: Int
     var teams_count: Int
     var can_upload_shot: Bool = false
     var type: String
     var pro: Bool = false
     var buckets_url: String
     var followers_url: String
     var following_url: String
     var likes_url: String
     var shots_url: String
     var teams_url: String
     var created_at: NSDate
     var updated_at: NSDate
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString(json["created_at"] as! String)!
        updated_at = dateFor.dateFromString(json["updated_at"] as! String)!
   
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        username = json["username"] as? String ?? ""
        html_url = json["html_url"] as? String ?? ""
        avatar_url = json["avatar_url"] as? String ?? ""
        bio = json["bio"] as? String ?? ""
        location = json["location"] as? String ?? ""
        links["web"] = (json["links"] as! NSDictionary)["web"] as? String ?? ""
        links["twitter"] = (json["links"] as! NSDictionary)["twitter"] as? String ?? ""
        buckets_count = json["buckets_count"] as? Int ?? 0
        comments_received_count = json["comments_received_count"] as? Int ?? 0
        followers_count = json["followers_count"] as? Int ?? 0
        followings_count = json["followings_count"] as? Int ?? 0
        likes_count = json["likes_count"] as? Int ?? 0
        likes_received_count = json["likes_received_count"] as? Int ?? 0
        projects_count = json["projects_count"] as? Int ?? 0
        rebounds_received_count = json["rebounds_received_count"] as? Int ?? 0
        shots_count = json["shots_count"] as? Int ?? 0
        teams_count = json["teams_count"] as? Int ?? 0
        can_upload_shot = json["can_upload_shot"] as! Bool
        type = json["type"] as? String ?? ""
        pro = json["pro"] as! Bool
        buckets_url = json["buckets_url"] as? String ?? ""
        followers_url = json["followers_url"] as? String ?? ""
        following_url = json["following_url"] as? String ?? ""
        likes_url = json["likes_url"] as? String ?? ""
        shots_url = json["shots_url"] as? String ?? ""
        teams_url = json["teams_url"] as? String ?? ""
    }
}

class DribbbleTeam: DribbbleUser {
}
