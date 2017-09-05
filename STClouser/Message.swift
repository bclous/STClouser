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
    
    public func createdAtString() -> String? {
        
        let calendar = Calendar.current
        let dayToday = calendar.component(.day, from: Date())
        let monthToday = calendar.component(.month, from: Date())
        let yearToday = calendar.component(.year, from: Date())
        let dayCreatedAt = calendar.component(.day, from: createdAt)
        let monthCreatedAt = calendar.component(.month, from: createdAt)
        let yearCreatedAt = calendar.component(.year, from: createdAt)
        
        let isSameDay = (dayToday == dayCreatedAt) && (monthToday == monthCreatedAt) && (yearToday == yearCreatedAt)
        
        if isSameDay {
            
            let dayHour = calendar.component(.hour, from: Date())
            let dayMinute = calendar.component(.minute, from: Date())
            let daySecond = calendar.component(.second, from: Date())
            let createdAtHour = calendar.component(.hour, from: createdAt)
            let createdAtMinute = calendar.component(.minute, from: createdAt)
            let createdAtSecond = calendar.component(.second, from: createdAt)
            
            let secondsDifference = ((dayHour - createdAtHour) * 3600) + ((dayMinute - createdAtMinute) * 60) + (daySecond - createdAtSecond)
            
            if secondsDifference < 60 {
                return String(secondsDifference) + "s"
            } else if secondsDifference < 3600 {
                let minutes = secondsDifference / 60
                return String(minutes) + "m"
            } else {
                return createdAt.string(withFormat: "h:mm a")
            }
        } else {
            return createdAt.string(withFormat: "M/d/yyyy, h:mm a")
        }
    }
}
