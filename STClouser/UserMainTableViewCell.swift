//
//  UserMainTableViewCell.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class UserMainTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    
    var user : User?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatCellWithUser(_ user: User) {
        
        userNameLabel.text = user.username
        nameLabel.text = user.name
        avatarImageView.image = user.avatarImage()
        let memberSinceDateString = user.dateString()
        if let dateString = memberSinceDateString {
            memberSinceLabel.text = "Member since: " + dateString
        }
    }
    
}
