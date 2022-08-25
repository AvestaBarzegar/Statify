//
//  Autolayout+Extensions.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import UIKit

extension UIView {
    func addAutolayoutSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func addAutolayoutSubview(_ subview: UIView) {
        addAutolayoutSubviews([subview])
    }
    
    func addSubviewFillToBounds(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        addAutolayoutSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
    }
}

extension UIViewController {
    func addChildFillToBounds(_ child: UIViewController, insets: UIEdgeInsets = .zero) {
        addChild(child)
        guard let childView = child.view else {
            debugPrint("Could not add childView to bounds: \(child)")
            return
        }
        view.addSubviewFillToBounds(childView, insets: insets)
    }
}

