//
//  SearchMoviesPresenter.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 01/04/22.
//

import UIKit

class SearchMoviesPresenter {
    private weak var _view: SearchMoviesViewProtocol?
    private let _interactor: SearchMoviesInteractor?
    private let _wireframe: SearchMoviesWireframe
    private var _items: [Movie]
    private var _searchTerms: [String]
    private var _pageNumber = 1
    var _currentSearchText = "" {
        didSet {
            if !self._searchTerms.contains(_currentSearchText) { self._searchTerms.insert(_currentSearchText, at: 0)}
        }
    }
    private var _viewMode: SearchMoviesViewMode = .search {
        didSet {
            self._view?.setupViewFor(mode: self._viewMode)
        }
    }
    
    init(view: SearchMoviesViewProtocol,
         interactor: SearchMoviesInteractor,
         wireframe: SearchMoviesWireframe) {
        
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._items = []
        self._searchTerms = []
    }
    
    private func loadSearchHistory() {
        self._interactor?.getSearchTerms { (result) in
            switch result {
            case .success(let data):
                self._searchTerms = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveSearchHistory() {
        self._interactor?.save(searchTerms: Array(self._searchTerms))
    }
    
    private func searchMovie(with text: String) {
        self._viewMode = .result
        self._view?.showLoader()
        self._interactor?.searchForMovie(with: text, page: _pageNumber) { [weak self] (result)in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?._items = movies
                    self?._searchTerms.append(text)
                    self?._view?.updateSearchResult()
                case.failure(let error):
                    self?._wireframe.showErrorAlert(with: error.localizedDescription)
                }
                self?._view?.hideLoader()
            }
        }
    }
    
}

extension SearchMoviesPresenter: SearchMoviesPresentationProtocol {
    var title: String {
        switch self._viewMode {
        case .search:
            return "Pesquisar filmes"
        case .result:
            return "Filmes pesquisados"
        }
    }
    
    var viewMode: SearchMoviesViewMode {
        return self._viewMode
    }
    
    func viewDidLoad() {
        self._viewMode = .search
        self.loadSearchHistory()
    }
    
    func viewWillDisappear(animated: Bool) {
        self.saveSearchHistory()
    }
    
    func handleShowSearchButton() {
        self._viewMode = .search
    }
    
    func searchBarCancelButtonClicked() {
        self._viewMode = .result
    }
    
    func searchBarSearchButtonClicked(with text: String) {
        self.searchMovie(with: text)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOrRows(in section: Int) -> Int {
        switch self._viewMode {
        case .search:
            return self._searchTerms.count
        case .result:
            return self._items.count
        }
    }
    
    func config(cell: PopularMoviesItemView, at indexPath: IndexPath) {
        let viewModel = MovieViewModel(movie: self._items[indexPath.row])
        cell.configView(with: viewModel)
    }
    
    func config(searchCell: SearchMoviesItemViewProtocol, at indexPath: IndexPath) {
        searchCell.configView(with: self._searchTerms[indexPath.row])
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if self._viewMode == .result { return }
        self.searchMovie(with: self._searchTerms[indexPath.row])
    }
}

