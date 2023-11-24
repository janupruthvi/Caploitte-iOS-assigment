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
    
    func getApiRequest<T: Decodable>(url: URL) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIError.serverError
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.dataError
        }
    }
    
    
}
