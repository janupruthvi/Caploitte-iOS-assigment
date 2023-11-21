//
//  NewsObjectModel.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-21.
//

import Foundation

struct NewsObjectModel: Codable {
    let articles: [ArticlesObjectModel?]
}

struct ArticlesObjectModel: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
