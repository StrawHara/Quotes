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
    
}
