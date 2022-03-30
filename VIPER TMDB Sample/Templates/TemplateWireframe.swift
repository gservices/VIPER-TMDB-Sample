//
//  TemplateWireframe.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

class TemplateWireframe {
    private var _viewController: UIViewController
    
    var viewController: UIViewController {
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self._viewController = viewController
    }
}

extension TemplateWireframe: WireframeProtocol {
    func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: "Algo deu errado", message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
