//
//  MovieViewModel.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

class MovieViewModel {
    let _movie: Movie
    
    init(movie: Movie) {
        self._movie = movie
    }
}

extension MovieViewModel: PopularMoviesPresentable {
    var name: String {
        return self._movie.title
    }
    
    var thumbnailURL: URL? {
        let fileSize = "w300"
        let urlString = "https://image.tmdb.org/t/p/\(fileSize)/\(self._movie.posterPath ?? "")"
       return URL(string: urlString)
    }
    
    var releaseDate: String {
        return self._movie.releaseDate ?? ""
    }
    
    var overView: String {
        return self._movie.overview
    }
}
