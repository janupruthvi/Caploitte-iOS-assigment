//
//  APIResource.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

struct APIResource {
    let path: String
    let queryParams: QueryRequestModel

    var url: URL {
        var components = URLComponents(string: APIEndpoints.baseUrl.rawValue)!
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "q", value: queryParams.keywords),
            URLQueryItem(name: "category", value: queryParams.category?.rawValue),
            URLQueryItem(name: "pageSize", value: "\(queryParams.pageSize)"),
            URLQueryItem(name: "page", value: "\(queryParams.page)"),
            URLQueryItem(name: "language", value: queryParams.language),
            URLQueryItem(name: "country", value: queryParams.country),
            URLQueryItem(name: "apiKey", value: queryParams.apiKey),
            
        ]
        return components.url!
    }
}
