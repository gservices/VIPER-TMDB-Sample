//
//  ViewController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 28/03/22.
//

import UIKit

extension UIViewController {
    func present(wireframe: TemplateWireframe, modalPresentationStyle: UIModalPresentationStyle, animated: Bool = true, completion: (() -> Void)? = nil) {
        wireframe.viewController.modalPresentationStyle = modalPresentationStyle
        present(wireframe.viewController, animated: animated, completion: completion)
    }    
}
