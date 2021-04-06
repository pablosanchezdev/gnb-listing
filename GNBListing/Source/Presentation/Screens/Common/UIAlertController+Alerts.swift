//
//  UIAlertController+Alerts.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 6/4/21.
//

import UIKit

extension UIAlertController {
    static func commonAcceptAlert(withTitle title: String, message: String) -> UIAlertController  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        return alert
    }
}
