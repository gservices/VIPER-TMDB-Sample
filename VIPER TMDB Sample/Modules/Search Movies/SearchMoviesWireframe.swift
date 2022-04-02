//
//  SearchMoviesWireframe.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 01/04/22.
//

import Foundation

class SearchMoviesWireframe: TemplateWireframe {
    init() {
        let moduleViewController = SearchMoviesViewController()
        super.init(viewController: moduleViewController)
        
        let moviesGateway = MoviesRemoteGateway(apiKey: AppConstants.apiKey)
        let searchTermsGateway = SearchLocalTermsGateway()
        
        let interactor = SearchMoviesInteractor(moviesGateway: moviesGateway, searchLocalTermsGateway: searchTermsGateway)
        
        let presenter = SearchMoviesPresenter(view: moduleViewController,
                                        interactor: interactor,
                                        wireframe: self)
        
        moduleViewController.presenter = presenter
    }
}
