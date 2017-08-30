//
//  ViewController.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class TrendingStocksVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        StockTwitsAPIClient.pullTrendingSymbols { (success) in
            
            let firstStock = DataStore.shared.trendingStocks[0] 
            let ticker = firstStock.symbol
            
            StockTwitsAPIClient.pullMessagesForSymbol(ticker, completionHandler: { (success) in
                print("trending stocks: \(DataStore.shared.trendingStocks.count)")
                print("users: \(DataStore.shared.users.count)")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension TrendingStocksVC:  UITableViewDelegate, UITableViewDataSource {
    
    func formatTableView() {
        
    }
    
}



