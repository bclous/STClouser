//
//  NoConnectionVC.swift
//  STClouser
//
//  Created by Brian Clouser on 9/4/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

protocol NoConnectionVCDelegate: class {
    func tryAgainButtonTapped()
}

class NoConnectionVC: UIViewController {
    
    weak var delegate : NoConnectionVCDelegate?

    @IBOutlet weak var tryAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryAgainButton.layer.cornerRadius = 5
    }

    @IBAction func tryAgainTapped(_ sender: Any) {
        delegate?.tryAgainButtonTapped()
    }


}
