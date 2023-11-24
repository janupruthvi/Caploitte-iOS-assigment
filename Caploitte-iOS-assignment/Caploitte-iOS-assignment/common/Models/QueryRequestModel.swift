//
//  ApiRequestModel.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

class QueryRequestModel {
    var category: NewsCategory? = nil
    var keywords: String? = nil
    var pageSize: Int = 10
    var page: Int = 1
    var country: String? = nil
    var language: String? = nil
    var apiKey: String = "9617bd6d0bf6426c8cee113b9b834237"
    
    init(){}
    
    func setCountryParam() {
        self.country = (UserDefaultService.shared.getLoggedConfigInfo().country)?.rawValue ?? "us"
    }
    
    func setLanguageParam() {
        self.language = (UserDefaultService.shared.getLoggedConfigInfo().language)?.rawValue ?? "en"
    }
}
