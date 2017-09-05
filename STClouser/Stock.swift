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
    
    convenience init(response: [String : Any]) {
        let stockID = response["id"] as? Int ?? 0
        let stockSymbol = response["symbol"] as? String ?? ""
        let stockTitle = response["title"] as? String ?? ""
        self.init(id: stockID, symbol: stockSymbol, title: stockTitle)
    }
    
    public func sortMessages(reverseChrono: Bool) {
        if reverseChrono {
            messages.sort(by: {$0.createdAt > $1.createdAt})
        } else {
            messages.sort(by: {$0.createdAt < $1.createdAt})
        }
    }
    
    public func clearAllMessages() {
        messages.removeAll()
    }
        
}
