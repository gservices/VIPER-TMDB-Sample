//
//  PopularMoviesInteractor.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

class PopularMoviesInteractor: PopularMoviesInteractionProtocol {
    private let gateway: MoviesRemoteGateway
    
    init(gateway: MoviesRemoteGateway) {
        self.gateway = gateway
    }
    
    func getRecentMovies(_ completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.gateway.getPopularMovies() { (result) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
