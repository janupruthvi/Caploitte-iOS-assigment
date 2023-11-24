//
//  Alerts.swift
//  Caploitte-iOS-assignment
//
//  Created by Pruthvi on 2023-11-24.
//

import UIKit

class AlertController {
    
    var viewController: UIViewController?
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        viewController?.present(alert, animated: true, completion: nil)
    }
    
}
