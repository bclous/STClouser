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
    let noConnectionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoConnectionVC") as! NoConnectionVC
    
    var stock : Stock?
    var chosenUser : User?
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatNavBar()
        
        formatTableView()
        formatNoConnectView()
        self.mainTableView.isHidden = true
        self.pullIndividualStockMessages()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserVC
        destinationVC.user = chosenUser
    }
    
    func pullIndividualStockMessages() {
        if let stock = stock {
            StockTwitsAPIClient.pullMessagesForSymbol(stock.symbol, completionHandler: { (success) in
                if success {
                    self.mainTableView.isHidden = false
                    self.mainTableView.reloadData()
                } else {
                    self.noConnectionVC.view.isHidden = false
                }
            })
        }
    }
    
    private func formatNoConnectView() {
        noConnectionVC.delegate = self
        constrainSubViewFullScreen(noConnectionVC.view, isActive: true)
        noConnectionVC.view.isHidden = true
    }
    
    private func formatNavBar() {
        title = stock?.symbol.uppercased()
    
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "ic_keyboard_arrow_left_white").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: -40, y: 0, width: 34, height: 34)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20;
        navigationItem.leftBarButtonItems = [negativeSpacer, UIBarButtonItem(customView: backButton)]
    }
    
    func handleBackButton() {
        navigationController?.popToRootViewController(animated: true)
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

extension IndividualStockVC: NoConnectionVCDelegate {
    
    func tryAgainButtonTapped() {
        noConnectionVC.view.isHidden = true
        pullIndividualStockMessages()
    }
}

extension IndividualStockVC: MessageCellDelegate {
    
    func userTapped(user: User) {
        chosenUser = user
        performSegue(withIdentifier: "userSegue", sender: nil)
    }
    
}
