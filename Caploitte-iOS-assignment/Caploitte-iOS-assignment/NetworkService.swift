//
//  NetworkService.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-21.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init () {}
    
    func getNewsFeed() async throws -> NewsObjectModel {
        let endpoint = "https://newsapi.org/v2/everything?q=tesla&from=2023-10-21&sortBy=publishedAt&apiKey=9617bd6d0bf6426c8cee113b9b834237"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIError.serverError
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(NewsObjectModel.self, from: data)
        } catch {
            throw APIError.dataError
        }
        
    }
    
    
}
