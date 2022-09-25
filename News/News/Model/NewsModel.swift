//
//  File.swift
//  News
//
//  Created by Zensar on 24/09/22.
//

import Foundation

struct NewsModel: Codable {
    let urlToImage: String?
    let author: String?
    let title: String?
    let publishedAt: String?
}

struct ResultNewsModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [NewsModel]
    init(status: String, totalResults: Int, articles: [NewsModel]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}
