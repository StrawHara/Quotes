//
//  UIView.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import UIKit

extension UIView {
 
    func addSubviews(_ views: UIView?...) {
        views.compactMap({ $0 }).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
 
    /** For instance: containerView.(view: viewToAddInFullSize) */
    func addInFullSize(_ view: UIView, constant: CGFloat = 0.0, addToSubview: Bool = false) {
        if addToSubview { self.addSubview(view) }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant)
        ])
    }
    
}
