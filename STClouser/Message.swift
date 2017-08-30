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
    let created_at : Date
    let user : User
    
    init(id: Int, body: String, created_at: Date, user: User) {
        self.id = id
        self.body = body
        self.created_at = created_at
        self.user = user
    }
}
