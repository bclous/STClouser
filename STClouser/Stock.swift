//
//  Stock.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class Stock: NSObject {
    
    let id : Int
    let symbol : String
    let title : String
    var messages : [Message]

    init(id: Int, symbol: String, title: String, messages: [Message]) {
        self.id = id
        self.symbol = symbol
        self.title = title
        self.messages = messages
    }
    
    convenience init(id: Int, symbol: String, title: String) {
        self.init(id: id, symbol: symbol, title: title, messages: [])
    }
    
    public func isMessageInStockDatabase(messageID: Int) -> Bool {
        for message in messages {
            if messageID == message.id {
                return true
            }
        }
        return false
    }
    
    public func sortMessages(reverseChrono: Bool) {
        if reverseChrono {
            messages.sort(by: {$0.created_at > $1.created_at})
        } else {
            messages.sort(by: {$0.created_at < $1.created_at})
        }
    }
}
