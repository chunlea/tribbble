//
//  DribbbleModels.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/29/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import Foundation

class DribbbleBucket: NSObject {
    internal var id: Int?
    internal var name: String?
    internal var descriptions: String?
    internal var shots_count: Int?
    internal var created_at: NSDate?
    internal var updated_at: NSDate?
    internal var user: DribbbleUser?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString((json["created_at"] as? String)!)
        updated_at = dateFor.dateFromString((json["updated_at"] as? String)!)
        
        id = json["id"] as? Int
        name = json["name"] as? String
        descriptions = json["description"] as? String
        shots_count = json["shots_count"] as? Int

        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleTeam(json: json["user"] as! NSDictionary)
        }

    }
}

class DribbbleProject: NSObject {
    internal var id: Int?
    internal var name: String?
    internal var descriptions: String?
    internal var shots_count: Int?
    internal var created_at: NSDate?
    internal var updated_at: NSDate?
    internal var user: DribbbleUser?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString((json["created_at"] as? String)!)
        updated_at = dateFor.dateFromString((json["updated_at"] as? String)!)
        
        id = json["id"] as? Int
        name = json["name"] as? String
        descriptions = json["descriptions"] as? String
        shots_count = json["shots_count"] as? Int

        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleTeam(json: json["user"] as! NSDictionary)
        }

    }
}

class DribbbleShot: NSObject {
    internal var id: Int?
    internal var title: String?
    internal var descriptions: String?
    internal var width: Int?
    internal var height: Int?
    internal var images: [String: String?] = [
        "hidpi": nil,
        "normal": nil,
        "teaser": nil
    ]
    internal var views_count: Int?
    internal var likes_count: Int?
    internal var comments_count: Int?
    internal var attachments_count: Int?
    internal var rebounds_count: Int?
    internal var buckets_count: Int?
    internal var html_url: String?
    internal var attachments_url: String?
    internal var buckets_url: String?
    internal var comments_url: String?
    internal var likes_url: String?
    internal var projects_url: String?
    internal var rebounds_url: String?
    internal var tags: [String] = []
    internal var user: DribbbleUser?
    internal var team: DribbbleTeam?
    internal var created_at: NSDate?
    internal var updated_at: NSDate?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString((json["created_at"] as? String)!)
        updated_at = dateFor.dateFromString((json["updated_at"] as? String)!)
        
        id = json["id"] as? Int
        title = json["title"] as? String
        descriptions = json["descriptions"] as? String
        width = json["width"] as? Int
        height = json["height"] as? Int
        images["hidpi"] = (json["images"] as! NSDictionary)["hidpi"] as? String
        images["normal"] = (json["images"] as! NSDictionary)["normal"] as? String
        images["teaser"] = (json["images"] as! NSDictionary)["teaser"] as? String
        views_count = json["views_count"] as? Int
        likes_count = json["likes_count"] as? Int
        comments_count = json["comments_count"] as? Int
        attachments_count = json["attachments_count"] as? Int
        rebounds_count = json["rebounds_count"] as? Int
        buckets_count = json["buckets_count"] as? Int
        html_url = json["html_url"] as? String
        attachments_url = json["attachments_url"] as? String
        buckets_url = json["buckets_url"] as? String
        comments_url = json["comments_url"] as? String
        likes_url = json["likes_url"] as? String
        projects_url = json["projects_url"] as? String
        rebounds_url = json["rebounds_url"] as? String
        tags = (json["tags"] as? [String])!

        if json["user"]!.isKindOfClass(NSDictionary) {
            user = DribbbleTeam(json: json["user"] as! NSDictionary)
        }
        
        if json["team"]!.isKindOfClass(NSDictionary) {
            team = DribbbleTeam(json: json["team"] as! NSDictionary)
        }
        
        
    }
}

class DribbbleAttachment: NSObject {
    internal var id: Int?
    internal var url: String?
    internal var thumbnail_url: String?
    internal var size: Int?
    internal var content_type: String?
    internal var views_count: Int?
    internal var created_at: NSDate?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString((json["created_at"] as? String)!)
        
        id = json["id"] as? Int
        url = json["url"] as? String
        thumbnail_url = json["thumbnail_url"] as? String
        size = json["size"] as? Int
        content_type = json["content_type"] as? String
        views_count = json["views_count"] as? Int
    }
}

class DribbbleUser: NSObject {
    internal var id: Int?
    internal var name: String?
    internal var username: String?
    internal var html_url: String?
    internal var avatar_url: String?
    internal var bio : String?
    internal var location: String?
    internal var links: [String: String?] = [
        "web": nil,
        "twitter" : nil
    ]
    internal var buckets_count: Int?
    internal var comments_received_count: Int?
    internal var followers_count: Int?
    internal var followings_count: Int?
    internal var likes_count: Int?
    internal var likes_received_count: Int?
    internal var projects_count: Int?
    internal var rebounds_received_count: Int?
    internal var shots_count: Int?
    internal var teams_count: Int?
    internal var can_upload_shot: Bool = false
    internal var type: String?
    internal var pro: Bool = false
    internal var buckets_url: String?
    internal var followers_url: String?
    internal var following_url: String?
    internal var likes_url: String?
    internal var shots_url: String?
    internal var teams_url: String?
    internal var created_at: NSDate?
    internal var updated_at: NSDate?
    
    init(json: NSDictionary) {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        created_at = dateFor.dateFromString((json["created_at"] as? String)!)
        updated_at = dateFor.dateFromString((json["updated_at"] as? String)!)
        
        id = json["id"] as? Int
        name = json["name"] as? String
        username = json["username"] as? String
        html_url = json["html_url"] as? String
        avatar_url = json["avatar_url"] as? String
        bio = json["bio"] as? String
        location = json["location"] as? String
        links["web"] = (json["links"] as! NSDictionary)["web"] as? String
        links["twitter"] = (json["links"] as! NSDictionary)["twitter"] as? String
        buckets_count = json["buckets_count"] as? Int
        comments_received_count = json["comments_received_count"] as? Int
        followers_count = json["followers_count"] as? Int
        followings_count = json["followings_count"] as? Int
        likes_count = json["likes_count"] as? Int
        likes_received_count = json["likes_received_count"] as? Int
        projects_count = json["projects_count"] as? Int
        rebounds_received_count = json["rebounds_received_count"] as? Int
        shots_count = json["shots_count"] as? Int
        teams_count = json["teams_count"] as? Int
        can_upload_shot = (json["can_upload_shot"] as? Bool)!
        type = json["type"] as? String
        pro = (json["pro"] as? Bool)!
        buckets_url = json["buckets_url"] as? String
        followers_url = json["followers_url"] as? String
        following_url = json["following_url"] as? String
        likes_url = json["likes_url"] as? String
        shots_url = json["shots_url"] as? String
        teams_url = json["teams_url"] as? String
    }
}

class DribbbleTeam: DribbbleUser {
}
