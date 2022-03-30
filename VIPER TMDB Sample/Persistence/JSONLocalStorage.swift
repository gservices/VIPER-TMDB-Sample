//
//  JSONLocalStorage.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

class JSONLocalStorage {
    private let storage: DiskStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        storage: DiskStorage,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }

    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }

    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
}
