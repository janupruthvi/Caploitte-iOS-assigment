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
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeScreenVC = storyboard.instantiateViewController(withIdentifier: "HomeScreenVC") as! HomeScreenViewController
        self.navigationController?.pushViewController(HomeScreenVC, animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let registerUserScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewVC") as! RegisterUserViewController
        self.navigationController?.pushViewController(registerUserScreenVC, animated: true)
    }
    
    

}
