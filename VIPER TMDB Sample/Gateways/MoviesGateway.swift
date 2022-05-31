//
//  MoviesGateway.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

typealias FetchMoviesGateway = (Result<[Movie], Error>) -> Void

protocol MoviesGateway {
    func getPopularMovies(_ completion: @escaping FetchMoviesGateway)
    func searchForMovie(with searchTerm: String, page: Int, completion: @escaping FetchMoviesGateway)
}

class MoviesRemoteGateway: NetworkService {}

extension MoviesRemoteGateway: MoviesGateway {
    func searchForMovie(with searchTerm: String, page: Int, completion: @escaping FetchMoviesGateway) {
        let apiClient = NetworkService(apiKey: AppConstants.apiKey)
        apiClient.send(SearchMoviesRequest(searchMovie: searchTerm, page: page)) { (result: Result<Movies<Movie>, Error>) in
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
        apiClient.send(PopularMoviesRequest()) { (result: Result<Movies<Movie>, Error>) in
            switch(result) {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
