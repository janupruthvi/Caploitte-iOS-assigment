//
//  ApiRequestModel.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

struct QueryRequestModel {
    let category: NewsCategory?
    let keywords: String?
    let pageSize: Int?
    let page: Int?
    let country: String? = "us"
    let apiKey: String = "9617bd6d0bf6426c8cee113b9b834237"
}
