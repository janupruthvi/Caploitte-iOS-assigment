//
//  AuthenticationService.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

class AuthenticationService {
    
    static let shared = AuthenticationService()
    
    let isUserLoggedIn = UserDefaultService.shared.getLoginStatus()
    
    var loggedInUsername: String?
    
    private let userDefaults = UserDefaultService.shared
    
    private init(){}
    
    
    func saveAndLoginUser(username: String, password: String) {
        self.userDefaults.storeLoginInfo(username: username, password: password)
        self.userDefaults.storeloginStatus(isLoggedIn: true)
    }
    
    func retriveAndValidateLogin(username: String, password: String) -> Bool {
        let loginInfo = self.userDefaults.getLoggedUserInfo(forUsername: username)
        
        
        guard let username = loginInfo.username, !username.isEmpty,
              let storedPassword = loginInfo.password, !password.isEmpty
        else {
            return false
        }
        
        if password != storedPassword {
            return false
        }
        
        self.loggedInUsername = username
        self.userDefaults.storeloginStatus(isLoggedIn: true)
        
        return true
    }
    
    func logoutUser() {
        self.userDefaults.storeloginStatus(isLoggedIn: false)
    }
    
    
    
}
