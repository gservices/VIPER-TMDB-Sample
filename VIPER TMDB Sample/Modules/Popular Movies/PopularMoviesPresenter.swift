//
//  PopularMoviesPresenter.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

class PopularMoviesPresenter {
    private unowned var _view: PopularMoviesViewProtocol
    private var _interactor: PopularMoviesInteractor
    private var _wireframe: PopularMoviesWireframe
    private var _movieItems: [Movie]
    private var _isLoading: Bool = false
    
    init(view: PopularMoviesViewProtocol, interactor: PopularMoviesInteractor, wireframe: PopularMoviesWireframe) {
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._movieItems = []
    }
    
    private func fetchMovies() {
        self._isLoading = true
        self._interactor.getRecentMovies() { [unowned self] (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let movies):
                    self._movieItems.append(contentsOf: movies)
                    self._view.updateView()
                case.failure(let error):
                    self._wireframe.showErrorAlert(with: error.localizedDescription)
                    self._view.hideLoader()
                    self._isLoading = false
                }
            }
        }
    }
}

extension PopularMoviesPresenter: PopularMoviesPresentationProtocol {
    var numberOfSections: Int {
        return 1
    }
    
    func viewDidLoad() {
        self._view.showLoader()
        self.fetchMovies()
    }
    
    func numberOrRows(in section: Int) -> Int {
        return self._movieItems.count
    }
    
    func config(cell: PopularMoviesItemView, at indexPath: IndexPath) {
        let viewModel = MovieViewModel(movie: self._movieItems[indexPath.row])
        cell.configView(with: viewModel)
    }
    
    func didScrollToEnd() {
        if _isLoading { return }
        self._view.showTableViewFooter()
        self.fetchMovies()
    }
}
