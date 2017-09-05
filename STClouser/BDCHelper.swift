//
//  BDCHelper.swift
//  STClouser
//
//  Created by Brian Clouser on 9/4/17.
//  Copyright © 2017 Brian Clouser. All rights reserved.
//

import Foundation
import UIKit



extension Date {
    
    public static func dateFromString(_ dateString: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    public static func isoDateFromString(_ dateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: dateString)
        return date
    }
    
    public func string(withFormat format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension UIViewController {
    
    public func presentAlertToUser(title: String, message:String, handler: @escaping (_ action: UIAlertAction) -> ()) {
        let importAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        importAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        self.present(importAlert, animated: true, completion: nil)
    }
    
    public func constrainSubViewFullScreen(_ subView: UIView, isActive: Bool) {
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = isActive
        subView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = isActive
        subView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = isActive
        subView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = isActive
    }
    
}

