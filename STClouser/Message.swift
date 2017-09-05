//
//  Message.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    let id : Int
    var body : String
    let createdAt : Date
    let user : User
    
    init(id: Int, body: String, createdAt: Date, user: User) {
        self.id = id
        self.body = body
        self.createdAt = createdAt
        self.user = user
    }
    
    convenience init(messageResponse: [String : Any]) {
        let messageID = messageResponse["id"] as? Int ?? 0
        let messageBody = messageResponse["body"] as? String ?? ""
        let messageCreatedAtString = messageResponse["created_at"] as? String ?? ""
        let messageCreatedAt = Date.isoDateFromString(messageCreatedAtString) ?? Date()
        
        let userDictionary = messageResponse["user"] as? [String : Any] ?? [:]
        let userID = userDictionary["id"] as? Int ?? 0
        
        let messageUser = DataStore.shared.userFromDatabaseFromID(userID) ?? User(userDictionary: userDictionary)
        self.init(id: messageID, body: messageBody, createdAt: messageCreatedAt, user: messageUser)
    }
    
    public func createdAtString() -> String {
        
        
        return ""
        
    }
}
