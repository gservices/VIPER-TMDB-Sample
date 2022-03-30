//
//  LayoutConstraint.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    static func pinning(view: UIView, attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute:toAttribute, multiplier: multiplier, constant: constant)
    }
    
    static func pinning(view: UIView, toView: UIView?, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
        return attributes.compactMap({ (attribute) -> NSLayoutConstraint in
            return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: multiplier, constant: constant)
        })
    }
    
    static func pinningEdges(view: UIView, toView: UIView?) -> [NSLayoutConstraint] {
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        return NSLayoutConstraint.pinning(view: view, toView: toView, attributes: attributes, multiplier: 1.0, constant: 0.0)
    }
    
    static func pinningEdgesToSuperview(view: UIView) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.pinningEdges(view: view, toView: view.superview)
    }
    
    static func pinningToSuperview(view: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.pinning(view: view, toView: view.superview, attributes: attributes, multiplier: multiplier, constant: constant)
    }
}
