//
//  ImageView.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    var activity: UIActivityIndicatorView  {
        let activity = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            activity.style = .medium
        } else {
            activity.style = .gray
        }
        
        self.addSubview(activity)
        activity.pinToSuperview(forAtrributes: [.centerX, .centerY])
        return activity
    }

    func loadImageFromUrl(url: URL)  {
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        self.showLoader()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.hideLoader()
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func showLoader() {
        self.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }

    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
