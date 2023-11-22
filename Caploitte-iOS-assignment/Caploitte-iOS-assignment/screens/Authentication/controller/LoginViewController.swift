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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loginUser() {
        
        guard let username = self.usernameTxtField.text, !username.isEmpty else {
            return
        }
        
        guard let passwordField = self.passwordField.text, !passwordField.isEmpty else {
            return
        }
        
        if AuthenticationService.shared.retriveAndValidateLogin(username: username,
                                                                password: passwordField) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let HomeScreenVC = storyboard.instantiateViewController(withIdentifier: "HomeScreenVC") as! HomeScreenViewController
            self.navigationController?.pushViewController(HomeScreenVC, animated: true)
            
        } else {
            print("login failed")
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
