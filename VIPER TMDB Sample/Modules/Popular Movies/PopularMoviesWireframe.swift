//
//  PopularMoviesWireframe.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 30/03/22.
//

import Foundation

class PopularMoviesWireframe: TemplateWireframe {
    init() {
        let moduleViewController = PopularMoviesViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = PopularMoviesInteractor(gateway: MoviesRemoteGateway(apiKey: AppConstants.apiKey))
        let presenter = PopularMoviesPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        
        moduleViewController.presenter = presenter
    }
}
