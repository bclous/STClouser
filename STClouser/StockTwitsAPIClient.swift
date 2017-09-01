//
//  StockTwitsAPIClient.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import Foundation
import Alamofire

class StockTwitsAPIClient {
    
    static let trendingURL = "https://api.stocktwits.com/api/2/trending/symbols.json"
    static let symbolURLPrefix = "https://api.stocktwits.com/api/2/streams/symbol/"
    
    public static func pullTrendingSymbols(completionHandler: @escaping (_ success: Bool) -> ()) {
        
        let request = Alamofire.request(trendingURL)
        request.responseJSON { (response) in
            
            if response.result.isFailure {
                completionHandler(false)
            } else {
                
                let responseDictionary = response.value as? [String : Any]
                let reponseArray = responseDictionary?["symbols"] as? [[String : Any]]
                if let responseArray = reponseArray {
                    addStocksToStoreFromResponse(responseArray)
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    public static func pullMessagesForSymbol(_ symbol: String, completionHandler: @escaping(_ success: Bool) -> ()) {
        
        let requestURL = symbolURLPrefix + symbol + ".json"
        let request = Alamofire.request(requestURL)
        request.responseJSON { (response) in
            
            if response.result.isFailure {
                completionHandler(false)
            } else {
                let responseDictionary = response.value as? [String : Any]
                let responseArray = responseDictionary?["messages"] as? [[String : Any]]
                let stock = DataStore.shared.stockFromSymbol(symbol)
                if let stock = stock, let responseArray = responseArray {
                    addMessagesToStock(stock, responseArray: responseArray)
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    private static func addStocksToStoreFromResponse(_ responseArray: [[String : Any]]) {
        
        DataStore.shared.emptyTrendingStocks()
        for stockDataResponse in responseArray {
            let id = stockDataResponse["id"] as? Int ?? 0
            let symbol = stockDataResponse["symbol"] as? String ?? ""
            let title = stockDataResponse["title"] as? String ?? ""
            
            if symbol != "" {
                let stock = Stock(id: id, symbol: symbol, title: title)
                DataStore.shared.trendingStocks.append(stock)
            }
        }
    }
    
    private static func addMessagesToStock(_ stock: Stock, responseArray: [[String : Any]]) {
        
        for messageResponse in responseArray {
            
            let id = messageResponse["id"] as? Int ?? 0
            
            if !stock.isMessageInStockDatabase(messageID: id){
                let body = messageResponse["body"] as? String ?? ""
                let createdAt = messageResponse["created_at"] as? String ?? ""
                let createdAtDate = isoDateFromString(createdAt) ?? Date()
                let userDictionary = messageResponse["user"] as? [String : Any] ?? [:]
                let userID = userDictionary["id"] as? Int ?? 0
                
                let userExists = DataStore.shared.isUserInDatabase(userID: userID)
                
                if userExists {
                    let user = DataStore.shared.userFromDatabaseFromID(userID)!
                    let message = Message(id: id, body: body, created_at: createdAtDate , user: user)
                    user.messages.append(message)
                    stock.messages.append(message)
                } else {
                    let userName = userDictionary["username"] as? String ?? ""
                    let name = userDictionary["name"] as? String ?? ""
                    let avatarURL = userDictionary["avatar_url"] as? String ?? ""
                    let avatarURLSSL = userDictionary["avatar_url_ssl"] as? String ?? ""
                    let joined = userDictionary["join_date"] as? String ?? ""
                    let joinDate = dateFromString(joined, dateFormat: "yyyy-MM-dd") ?? Date()
                    let official = userDictionary["official"] as? Bool ?? false
                    
                    let user = User(id: userID, username: userName, name: name, avatarURL: avatarURL, avatarSSL: avatarURLSSL, join_date: joinDate, official: official, messages: [])
                    DataStore.shared.users.append(user)
                    let message = Message(id: id, body: body, created_at: createdAtDate, user: user)
                    stock.messages.append(message)
                    user.messages.append(message)
                }
            }
        }
        
        stock.sortMessages(reverseChrono: true)
    }
    
    private static func dateFromString(_ dateString: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    private static func isoDateFromString(_ dateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: dateString)
        return date
    }
    
}
