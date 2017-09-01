//
//  DataStore.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class DataStore: NSObject {
    
    static let shared = DataStore()
    var trendingStocks : [Stock] = []
    var users : [User] = []
    
    
    public func emptyTrendingStocks() {
        trendingStocks.removeAll()
    }
    
    public func stockFromSymbol(_ symbol: String) -> Stock? {
        for stock in trendingStocks {
            if stock.symbol == symbol {
                return stock
            }
            
        }
        return nil
    }
    
    public func isUserInDatabase(userID: Int) -> Bool {
        for user in users {
            if user.id == userID {
                return true
            }
        }
        
        return false
    }
    
        
    public func userFromDatabaseFromID(_ userID: Int) -> User? {
        for user in users {
            if user.id == userID {
                return user
            }
        }
        
        return nil
    }
    
    
    
    
}
