//
//  PopularMoviesRequest.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

struct PopularMoviesRequest: APIRequest {
    typealias Response = Movies<Movie>
    var resourceName: String {
        return "/3/movie/popular"
    }
}
