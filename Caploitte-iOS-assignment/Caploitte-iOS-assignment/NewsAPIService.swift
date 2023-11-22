//
//  NewsService.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import Foundation

class NewsAPIService {
    
    static let shared = NewsAPIService()
    
    private init () {}

    private let network = NetworkService.shared
    
    func getAllNews(queryReuest: QueryRequestModel) async throws -> NewsObjectModel {
        let endpoint = "https://newsapi.org/v2/everything?q=tesla&from=2023-10-21&sortBy=publishedAt&apiKey=9617bd6d0bf6426c8cee113b9b834237"
        do {
            return try await self.network.getApiRequest(endpoint: endpoint) as NewsObjectModel
        } catch {
            throw error
        }
        
    }
    
    func getHeadLineNews(queryReuest: QueryRequestModel) async throws -> NewsObjectModel {
        let endpoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9617bd6d0bf6426c8cee113b9b834237"
        do {
            return try await self.network.getApiRequest(endpoint: endpoint) as NewsObjectModel
        } catch {
            throw error
        }
        
    }
    
    
}
