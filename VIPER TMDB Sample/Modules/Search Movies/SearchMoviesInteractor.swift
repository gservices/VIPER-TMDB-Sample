//
//  SearchMoviesInteractor.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 31/03/22.
//

import Foundation

class SearchMoviesInteractor {
    private let _moviesGateway: MoviesGateway
    private let _searchLocalTermsGateway: SearchLocalTermsGateway
    
    init(moviesGateway: MoviesGateway, searchLocalTermsGateway: SearchLocalTermsGateway) {
        self._moviesGateway = moviesGateway
        self._searchLocalTermsGateway = searchLocalTermsGateway
    }
}

extension SearchMoviesInteractor: SearchMoviesInteractorProtocol {
    func searchForMovie(with searchTerm: String, page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        self._moviesGateway.searchForMovie(with: searchTerm, page: page) { result in
           completion(result)
        }
    }
    
    func getSearchTerms(_ completion: @escaping FetchLocalTermsCompletion) {
        self._searchLocalTermsGateway.getSearchLocalHistory { (result) in
            completion(result)
        }
    }
    
    func save(searchTerms: [String]) {
        self._searchLocalTermsGateway.save(searchTerms: searchTerms)
    }
}
