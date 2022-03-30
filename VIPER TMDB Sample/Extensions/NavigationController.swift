//
//  NavigationController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 28/03/22.
//

import UIKit

extension UINavigationController {
    func push(route router: TemplateWireframe, animated: Bool = true) {
        self.pushViewController(router.viewController, animated: animated)
    }
    
    func setRootRoute(_ route: TemplateWireframe, animated: Bool = true) {
        self.setViewControllers([route.viewController], animated: animated)
    }
}
