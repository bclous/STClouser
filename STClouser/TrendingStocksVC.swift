//
//  ViewController.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class TrendingStocksVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    var chosenStock : Stock?
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StockTwitsAPIClient.pullTrendingSymbols { (success) in
            self.formatTableView()
            self.mainTableView.reloadData()
        }
        title = "Trending"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
    }
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! IndividualStockVC
        destinationVC.stock = chosenStock
     }
    
}

extension TrendingStocksVC:  UITableViewDelegate, UITableViewDataSource {
    
    func formatTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "TrendingStockCell", bundle: nil), forCellReuseIdentifier: "stockCell")
        formatRefreshControl()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! TrendingStockCell
        let stock = DataStore.shared.trendingStocks[indexPath.row]
        cell.formatCellWithStock(stock)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.trendingStocks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenStock = DataStore.shared.trendingStocks[indexPath.row]
        performSegue(withIdentifier: "individualStockSegue", sender: nil)
    }
    
    func refreshTrendingStocks() {
        StockTwitsAPIClient.pullTrendingSymbols { (success) in
            self.refreshControl.endRefreshing()
            self.mainTableView.reloadData()
        }

    }
    
    func formatRefreshControl() {
        if #available(iOS 10.0, *) {
            mainTableView.refreshControl = refreshControl
        } else {
            mainTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTrendingStocks), for: .valueChanged)
    }
    
}



