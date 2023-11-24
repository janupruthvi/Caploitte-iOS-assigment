//
//  LoginViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let alert = AlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.viewController = self
    }
    
    func loginUser() {
        
        guard let username = self.usernameTxtField.text, !username.isEmpty else {
            alert.showAlert(title: "Unable to Login", message: "username is required")
            return
        }
        
        guard let passwordField = self.passwordField.text, !passwordField.isEmpty else {
            alert.showAlert(title: "Unable to Login", message: "password is required")
            return
        }
        
        if AuthenticationService.shared.retriveAndValidateLogin(username: username,
                                                                password: passwordField) {
            
            let window = view.window
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewVC = storyboard.instantiateViewController(withIdentifier: "HomeRootNavigationVC")
            window?.rootViewController = loginViewVC
            window?.makeKeyAndVisible()
            
        } else {
            alert.showAlert(title: "Unable to Login", message: "Invalid credentials provided")

        }
        
    }
    
    func navigateToSignUp() {
        let registerUserScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewVC") as! RegisterUserViewController
        self.navigationController?.pushViewController(registerUserScreenVC, animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        self.loginUser()
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        self.navigateToSignUp()
    }
    
    

}
