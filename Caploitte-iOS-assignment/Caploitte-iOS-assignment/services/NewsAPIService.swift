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
        
        let endpoint = APIResource(path: APIEndpoints.everythingEndpoint.rawValue,
                                   queryParams: queryReuest).url
        do {
            return try await self.network.getApiRequest(url: endpoint) as NewsObjectModel
        } catch {
            throw error
        }
        
    }
    
    func getHeadLineNews(queryReuest: QueryRequestModel) async throws -> NewsObjectModel {
        
        let endpoint = APIResource(path: APIEndpoints.headlinesEndpoint.rawValue,
                                   queryParams: queryReuest).url
        print("endpoint -", endpoint.absoluteString)
        do {
            return try await self.network.getApiRequest(url: endpoint) as NewsObjectModel
        } catch {
            throw error
        }
        
    }
    
    
}
