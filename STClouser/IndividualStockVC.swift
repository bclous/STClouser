//
//  IndividualStockVC.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class IndividualStockVC: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var stock : Stock?
    var chosenUser : User?
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatTableView()
        if let stock = stock {
            title = stock.symbol
            StockTwitsAPIClient.pullMessagesForSymbol(stock.symbol, completionHandler: { (success) in
                if success {
                    self.mainTableView.reloadData()
                } else {
                    //pop up to retry
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserVC
        destinationVC.user = chosenUser
    }
}

extension IndividualStockVC : UITableViewDelegate, UITableViewDataSource {
    
    func formatTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        mainTableView.estimatedRowHeight = 68.0
        mainTableView.rowHeight = UITableViewAutomaticDimension
        formatRefreshControl()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell
        cell.delegate = self
        if let stock = stock {
            let message = stock.messages[indexPath.row]
            cell.formatCellWithMessage(message)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stock = stock {
            return stock.messages.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func formatRefreshControl() {
        if #available(iOS 10.0, *) {
            mainTableView.refreshControl = refreshControl
        } else {
            mainTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshMessages), for: .valueChanged)
    }
    
    func refreshMessages() {
        if let stock = stock {
            StockTwitsAPIClient.pullMessagesForSymbol(stock.symbol, completionHandler: { (success) in
                self.refreshControl.endRefreshing()
                self.mainTableView.reloadData()
            })
            
        }
    }
    

}

extension IndividualStockVC: MessageCellDelegate {
    
    func userTapped(user: User) {
        chosenUser = user
        performSegue(withIdentifier: "userSegue", sender: nil)
    }
    
}
