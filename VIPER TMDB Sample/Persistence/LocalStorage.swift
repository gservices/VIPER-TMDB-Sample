//
//  LocalStorage.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void
typealias LocalStorage = ReadableStorage & WritableStorage

protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func save(value: Data, for key: String, handler: @escaping Handler<Data>)
}

enum LocalStorageError: Error {
    case notFound
    case cantWrite(Error)
}

