//
//  PopularMoviesProtocols.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

protocol PopularMoviesViewProtocol: ViewerProtocol {
    func updateView()
    func showTableViewFooter()
    func hideTableViewFooter()
}

protocol PopularMoviesPresentationProtocol: PresenterProtocol {
    var numberOfSections: Int { get }
    func numberOrRows(in section: Int) -> Int
    func config(cell: PopularMoviesItemView, at indexPath: IndexPath)
    func didScrollToEnd()
}

protocol PopularMoviesInteractionProtocol: InteractorProtocol {
    func getRecentMovies(_ completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol PopularMoviesItemView {
    func configView(with viewModel: PopularMoviesPresentable)
}

protocol PopularMoviesPresentable {
    var name: String { get }
    var thumbnailURL: URL? { get }
    var releaseDate: String { get }
    var overView: String { get }
}
