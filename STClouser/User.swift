//
//  User.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let id : Int
    var username : String
    var name : String
    var avatarURL : String
    var avatarSSL : String
    var join_date : Date
    var official : Bool
    var messages : [Message]
    
    init(id: Int, username: String, name: String, avatarURL: String, avatarSSL: String, join_date: Date, official: Bool, messages: [Message]) {
        self.id = id
        self.username = username
        self.name = name
        self.avatarURL = avatarURL
        self.avatarSSL = avatarSSL
        self.join_date = join_date
        self.official = official
        self.messages = messages
    }
    
    convenience init(userDictionary: [String : Any]) {
        let userIDFromDictionary = userDictionary["id"] as? Int ?? 0
        let userNameFromDictionary = userDictionary["username"] as? String ?? ""
        let nameFromDictionary = userDictionary["name"] as? String ?? ""
        let avatarURLFromDictionary = userDictionary["avatar_url"] as? String ?? ""
        let avatarURLSSLFromDictionary = userDictionary["avatar_url_ssl"] as? String ?? ""
        let joinedFromDictionary = userDictionary["join_date"] as? String ?? ""
        let joinDateFromDictionary = Date.dateFromString(joinedFromDictionary, dateFormat: "yyyy-MM-dd") ?? Date()
        let officialFromDictionary = userDictionary["official"] as? Bool ?? false
        self.init(id: userIDFromDictionary, username: userNameFromDictionary, name: nameFromDictionary, avatarURL: avatarURLFromDictionary, avatarSSL: avatarURLSSLFromDictionary, join_date: joinDateFromDictionary, official: officialFromDictionary, messages: [])
    }
    
    public func avatarImage() -> UIImage? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(id).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        
        return nil
    }
    
    public func dateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter.string(from: join_date)
    }
    
    public func cacheAvatarImage(_ image: UIImage) {
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(id).png")
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch { }
    }
    
    
    


}
