//
//  UserDefaultService.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

class UserDefaultService {
    
    static let shared = UserDefaultService()
    let userDefaultKey: String = "LOGIN_STATUS"
    
    private let userDefaults: UserDefaults
    

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeLoginInfo(username: String, password: String) {
        let loginInfo = (username: username, password: password)
        saveValue(value: loginInfo, key: username)
    }
    
    func storeloginStatus(isLoggedIn: Bool){
        saveValue(value: isLoggedIn, key: self.userDefaultKey)
    }
    
    func getLoggedUserInfo(forUsername username: String) -> (username: String?, password: String?) {
        let usernameInfo: (username: String?, password: String?)? = readValue(key: username)
        return (usernameInfo?.username, usernameInfo?.password)
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
