//
//  MoviesGateway.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

typealias FetchMoviesGateway = (Result<[Movie], Error>) -> Void
typealias FetchSearchTermsGateway = (Swift.Result<[String], Error>) -> Void

protocol MoviesGateway {
    func getPopularMovies(_ completion: @escaping FetchMoviesGateway)
    func searchforMovie(with searchTerm: String, page: Int, completion: @escaping FetchMoviesGateway)
}

protocol SearchMoviesGateway {
    func getSearchHistory(completion: @escaping FetchSearchTermsGateway)
    func save(searchTerms: [String])
}

class MoviesRemoteGateway: NetworkService {}

extension MoviesRemoteGateway: MoviesGateway {
    func searchforMovie(with searchTerm: String, page: Int, completion: @escaping FetchMoviesGateway) {
        let apiClient = NetworkService(apiKey: AppConstants.apiKey)
        apiClient.send(SearchMoviesRequest(searchMovie: searchTerm, page: page)) { (result: Result<ResponseData<Movie>, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPopularMovies(_ completion: @escaping FetchMoviesGateway) {
        let apiClient = NetworkService(apiKey: AppConstants.apiKey)
        apiClient.send(PopularMoviesRequest()) { (result: Result<ResponseData<Movie>, Error>) in
            switch(result) {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
