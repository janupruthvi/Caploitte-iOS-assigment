//
//  UserDefaultService.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

class UserDefaultService {
    
    static let shared = UserDefaultService()
    
    private let userDefaults: UserDefaults
    private let userDefaultKey: String = "LOGIN_STATUS"
    private let userNameKey:String = "username"
    private let passwordKey: String = "password"
    

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeLoginInfo(username: String, password: String) {
        let loginInfo: [String: Any] = [userNameKey: username, passwordKey: password]
        saveValue(value: loginInfo, key: username)
    }
    
    func storeloginStatus(isLoggedIn: Bool){
        saveValue(value: isLoggedIn, key: self.userDefaultKey)
    }
    
    func getLoggedUserInfo(forUsername username: String) -> (username: String?, password: String?) {
        let usernameInfo: [String: Any]? = readValue(key: username)
        return (usernameInfo?[userNameKey] as? String,
                usernameInfo?[passwordKey] as? String)
    }
    
    func getLoginStatus() -> Bool {
        let usernameInfo: Bool? = readValue(key: userDefaultKey)
        return usernameInfo ?? false
    }
    
    private func saveValue(value: Any, key: String) {
        userDefaults.set(value, forKey: key)
    }
    private func readValue<T>(key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
}
