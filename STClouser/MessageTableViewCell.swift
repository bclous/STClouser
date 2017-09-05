//
//  MessageTableViewCell.swift
//  STClouser
//
//  Created by Brian Clouser on 8/30/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit
import Alamofire

protocol MessageCellDelegate : class {
    func userTapped(user: User)
}

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    weak var delegate : MessageCellDelegate?
    var message : Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatCellWithMessage(_ message: Message) {
        
        self.message = message
        userName.text = message.user.username
        messageBody.text = message.body
        avatarImageView.layer.cornerRadius = 10
        timeStamp.text = message.createdAtString()
        
        let avatarImage = message.user.avatarImage()
        
        if let avatarImage = avatarImage {
            avatarImageView.image = avatarImage
        } else {
            let imageURL = message.user.avatarSSL
            Alamofire.request(imageURL).responseData { response in
                if let data = response.result.value {
                    self.avatarImageView.image = UIImage(data: data)
                    message.user.cacheAvatarImage(UIImage(data: data)!)
                }
            }

        }
    }
    
    @IBAction func avatarTapped(_ sender: Any) {
        delegate?.userTapped(user: message!.user)
    }
}
