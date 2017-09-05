//
//  UserVC.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
    
    var user: User?
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTableView()
        formatNavBar()
    }
    
    private func formatNavBar() {
        title = user?.username
        
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "ic_keyboard_arrow_left_white").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: -40, y: 0, width: 34, height: 34)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20;
        navigationItem.leftBarButtonItems = [negativeSpacer, UIBarButtonItem(customView: backButton)]
    }
    
    func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }


}

extension UserVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func formatTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "UserMainTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        mainTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserMainTableViewCell
        if let user = user {
            cell.formatCellWithUser(user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = user {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
