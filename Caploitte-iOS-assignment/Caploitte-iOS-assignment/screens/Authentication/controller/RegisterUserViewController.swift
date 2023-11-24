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
    
    let alert = AlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.viewController = self
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        self.register()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func register() {
        
        guard validation() else {
            alert.showAlert(title: "Registration failed", message: "Please provide valid data")
            return
        }
        
        if let username = self.usernameField.text,
           let passwordField = self.passwordField.text {
            AuthenticationService.shared.saveAndLoginUser(username: username, password: passwordField)
            let window = view.window
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewVC = storyboard.instantiateViewController(withIdentifier: "HomeRootNavigationVC")
            window?.rootViewController = loginViewVC
            window?.makeKeyAndVisible()
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
        
        guard passwordField == confirmPasswordField else {
            return false
        }
        
        return true
        
    }
    
    

}
