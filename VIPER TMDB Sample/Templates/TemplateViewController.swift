//
//  TemplateViewController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

class TemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            activity.style = .large
        } else {
            activity.style = .whiteLarge
        }
        
        activity.color = .red
        self.view.addSubview(activity)
        activity.pinToSuperview(forAtrributes: [.centerX, .centerY])
        return activity
    }()
}

extension TemplateViewController: ViewerProtocol {
    func showLoader() {
        view.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
