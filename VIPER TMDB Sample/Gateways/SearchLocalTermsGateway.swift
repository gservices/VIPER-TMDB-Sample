//
//  SearchLocalTermsGateway.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 31/03/22.
//

import Foundation

typealias FetchLocalTermsCompletion = (Swift.Result<[String], Error>) -> Void

protocol SearchLocalTermsGatewayProtocol {
    func getSearchLocalHistory(completion: @escaping FetchLocalTermsCompletion)
    func save(searchTerms: [String])
}

class SearchLocalTermsGateway {
    private let SEARCH_KEY = "br.com.gservices.VIPERTMDBSample"
    private let storage: JSONLocalStorage
    
    init() {
        let path = URL(fileURLWithPath: NSTemporaryDirectory())
        let disk = DiskStorage(path: path)
        storage = JSONLocalStorage(storage: disk)
    }
}

extension SearchLocalTermsGateway: SearchLocalTermsGatewayProtocol {
    func getSearchLocalHistory(completion: @escaping FetchLocalTermsCompletion) {
        do {
            let result: [String] = try self.storage.fetch(for: SEARCH_KEY)
            completion(.success(result))
        } catch {
            completion(.failure(LocalStorageError.notFound))
        }
    }
    
    func save(searchTerms: [String]) {
        do {
            try self.storage.save(searchTerms, for: SEARCH_KEY)
        } catch {
            print(error)
        }
    }
}
