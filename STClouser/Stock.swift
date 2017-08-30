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
    
}
