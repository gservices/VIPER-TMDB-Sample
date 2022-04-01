//
//  AppConstants.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

struct AppConstants {
    static let apiKey: String = "8b2464341564a9fcef35bd8a88d770c5"
    static let baseURL: String = "https://api.themoviedb.org/"
    static let thumbnailURL: String = "https://image.tmdb.org/t/p/"
}

enum VersionAPI: String {
    case tree = "3/"
    case four = "4/"
}
