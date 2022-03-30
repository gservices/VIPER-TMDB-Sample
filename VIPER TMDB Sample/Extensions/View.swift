//
//  View.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation
import UIKit

extension UIView {
    func pinEdgesToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        let constraints = NSLayoutConstraint.pinningEdgesToSuperview(view: self)
        superview.addConstraints(constraints)
    }
    
    func pinToSuperview(forAtrributes attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        let constraints = NSLayoutConstraint.pinningToSuperview(view: self, attributes: attributes, multiplier: multiplier, constant: constant)
        superview.addConstraints(constraints)
    }
    
    func pin(toView: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        let constraints = NSLayoutConstraint.pinning(view: self, toView: toView, attributes: attributes, multiplier: multiplier, constant: constant)
        superview.addConstraints(constraints)
    }
    
    func pin(attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        let constraint = NSLayoutConstraint.pinning(view: self, attribute: attribute, toView: toView, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        superview.addConstraint(constraint)
    }
}
