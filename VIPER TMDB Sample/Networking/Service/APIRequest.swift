//
//  APIRequest.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation
protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var resourceName: String { get }
}

enum SearchError: Error {
    case noMatches
}
