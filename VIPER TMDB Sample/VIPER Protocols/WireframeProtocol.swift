//
//  WireframeProtocol.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 28/03/22.
//

import Foundation
import UIKit

protocol WireframeProtocol: AnyObject {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)
    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}
