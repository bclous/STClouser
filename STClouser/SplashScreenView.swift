//
//  SplashScreenView.swift
//  STClouser
//
//  Created by Brian Clouser on 9/4/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import UIKit

class SplashScreenView: UIView {

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let logoImageView = UIImageView(image: UIImage(named: "stlogo"))
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundColor = UIColor.white
    }
}
