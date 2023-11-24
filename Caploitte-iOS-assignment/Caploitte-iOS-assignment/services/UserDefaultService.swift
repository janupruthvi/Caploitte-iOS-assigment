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
    private let userConfigKey: String = "USER_CONFIGS"
    private let loggedUsernameKey: String = "LOGGED_IN_USER"
    private let userNameKey:String = "username"
    private let passwordKey: String = "password"
    private let countryKey:String = "country"
    private let languageKey: String = "language"
    

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeLoginInfo(username: String, password: String) {
        let loginInfo: [String: Any] = [userNameKey: username, passwordKey: password]
        saveValue(value: loginInfo, key: username)
        saveValue(value: username, key: loggedUsernameKey)
    }
    
    func storeloginStatus(isLoggedIn: Bool){
        saveValue(value: isLoggedIn, key: self.userDefaultKey)
    }
    
    func storeUserConfig(country: String, language: String) {
        let userConfigInfo: [String: Any] = [countryKey: country, languageKey: language]
        print("check country", country)
        print("check language", language)
        saveValue(value: userConfigInfo, key: userConfigKey)
    }
    
    func getLoggedUserInfo(forUsername username: String) -> (username: String?, password: String?) {
        let usernameInfo: [String: Any]? = readValue(key: username)
        if let currentUser = usernameInfo?[userNameKey] {
            saveValue(value: currentUser, key: loggedUsernameKey)
        }
        return (usernameInfo?[userNameKey] as? String,
                usernameInfo?[passwordKey] as? String)
    }
    
    func getLoggedConfigInfo() -> (country: Country?, language: Language?) {
        let userConfig: [String: Any]? = readValue(key: userConfigKey)
        let language = Language(rawValue: userConfig?[languageKey] as? String ?? "")
        let country = Country(rawValue: userConfig?[countryKey] as? String ?? "")
        return (country,language)
    }
    
    func getLoginStatus() -> Bool {
        let usernameInfo: Bool? = readValue(key: userDefaultKey)
        return usernameInfo ?? false
    }
    
    func getLoggedInUsername() -> String {
        let usernameInfo: String? = readValue(key: loggedUsernameKey)
        return usernameInfo ?? ""
    }
    
    func removeUserConfigData() {
        userDefaults.removeObject(forKey: userConfigKey)
    }
    
    private func saveValue(value: Any, key: String) {
        userDefaults.set(value, forKey: key)
    }
    private func readValue<T>(key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
}
