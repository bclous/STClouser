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

}
