//
//  URLQueryItemEncoder.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

enum URLQueryItemEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameters].self, from: parametersData)
        return parameters.map { URLQueryItem(name: $0, value: $1.description) }
    }
}
