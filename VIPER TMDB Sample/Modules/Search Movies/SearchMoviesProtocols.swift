//
//  SearchMoviesProtocols.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 31/03/22.
//

import Foundation

enum SearchMoviesViewMode {
    case search
    case result
}

protocol SearchMoviesItemViewProtocol {
    func configView(with searchTerm: String)
}

protocol SearchMoviesViewProtocol: ViewerProtocol {
    func setupViewFor(mode: SearchMoviesViewMode)
    func searchBar(shouldBecomeFirstResponder: Bool)
    func updateSearchBarText(_ text: String)
    func updateSearchResult()
}

protocol SearchMoviesPresentationProtocol: PresenterProtocol {
    var viewMode: SearchMoviesViewMode { get }
    var numberOfSections: Int { get }
    var title: String { get }
    func handleShowSearchButton()
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(with text: String)
    func numberOrRows(in section: Int) -> Int
    func config(cell: PopularMoviesItemView, at indexPath: IndexPath)
    func config(searchCell: SearchMoviesItemViewProtocol, at indexPath: IndexPath)
    func didSelectRow (at indexPath: IndexPath)
}

protocol SearchMoviesInteractorProtocol: InteractorProtocol {
    func searchForMovie(with searchTerm: String, page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void)
    func getSearchTerms(_ completion: @escaping FetchSearchTermsGateway)
    func save(searchTerms: [String])
}

protocol SearchMoviesWireframeProtocol: WireframeProtocol {}

