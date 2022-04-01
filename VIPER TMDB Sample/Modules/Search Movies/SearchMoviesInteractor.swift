//
//  SearchMoviesInteractor.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 31/03/22.
//

import Foundation

class SearchMoviesInteractor {
    private let _moviesGateway: MoviesGateway
    private let _searchMoviesGateway: SearchMoviesGateway
    
    init(moviesGateway: MoviesGateway, searchMoviesGateway: SearchMoviesGateway) {
        self._moviesGateway = moviesGateway
        self._searchMoviesGateway = searchMoviesGateway
    }
}

extension SearchMoviesInteractor: SearchMoviesInteractorProtocol {
    func searchForMovie(with searchTerm: String, page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        self._moviesGateway.searchforMovie(with: searchTerm, page: page) { result in
           completion(result)
        }
    }
    
    func getSearchTerms(_ completion: @escaping FetchSearchTermsGateway) {
        /// TODO Implement
    }
    
    func save(searchTerms: [String]) {
        /// TODO Implement
    }
    
    
}
