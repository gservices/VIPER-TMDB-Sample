//
//  ResponseData.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

struct Movies<Model: Codable>: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Model]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
