//
//  RegisterUserViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func register() {
        
        guard validation() else {
            return
        }
        
        
        
        
    }
    
    func validation() -> Bool {
        
        guard let username = self.usernameField.text, !username.isEmpty else {
            return false
        }
        
        guard let passwordField = self.passwordField.text, !passwordField.isEmpty else {
            return false
        }
        
        guard let confirmPasswordField = self.confirmPasswordField.text, !confirmPasswordField.isEmpty else {
            return false
        }
        
        guard passwordField != confirmPasswordField else {
            return false
        }
        
        return true
        
    }
    
    

}
