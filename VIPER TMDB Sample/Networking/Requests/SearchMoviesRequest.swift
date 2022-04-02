//
//  SearchMoviesRequest.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 31/03/22.
//

import Foundation

struct SearchMoviesRequest: APIRequest {
    private let query: String
    private let page: Int
    
    typealias Response = ResponseData<Movie>
    var resourceName: String {
        return "/3/search/movie/"
    }
    
    init(searchMovie: String, page: Int = 1) {
        self.query = searchMovie
        self.page = page
    }
}
