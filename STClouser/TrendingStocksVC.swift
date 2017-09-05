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
    let splashScreen = SplashScreenView()
    let noConnectionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoConnectionVC") as! NoConnectionVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatNavBar()
        formatSupplementalViews()
        formatTableView()
        pullTrendingStocks()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! IndividualStockVC
        destinationVC.stock = chosenStock
     }
    
    func formatSupplementalViews() {
        constrainSubViewFullScreen(splashScreen, isActive: true)
        splashScreen.isHidden = false
        constrainSubViewFullScreen(noConnectionVC.view, isActive: true)
        noConnectionVC.delegate = self
        noConnectionVC.view.isHidden = true
    }
    
    func pullTrendingStocks() {
        StockTwitsAPIClient.pullTrendingSymbols { (success) in
            self.splashScreen.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            if success {
                self.mainTableView.reloadData()
                self.mainTableView.isHidden = false
            } else {
                self.noConnectionVC.view.isHidden = false
            }
        }
    }
    
    private func formatNavBar() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "stWatermark"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 25)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        navigationController?.automaticallyAdjustsScrollViewInsets = false
        //navigationController?.navigationBar.tintColor = UIColor.white
        
        //navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 62/255.0, green: 88/255.0, blue: 110/255.0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
}

extension TrendingStocksVC:  UITableViewDelegate, UITableViewDataSource {
    
    func formatTableView() {
        mainTableView.isHidden = true
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

extension TrendingStocksVC: NoConnectionVCDelegate {
    func tryAgainButtonTapped() {
        noConnectionVC.view.isHidden = true
        self.pullTrendingStocks()
    }
}



