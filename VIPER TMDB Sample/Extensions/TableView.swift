//
//  TableView.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

extension UITableView {
    func emptyDataPresentation() {
        let imageView = UIImageView(image: UIImage(named: "no-data"))
        imageView.contentMode = .center
        self.backgroundView = imageView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
