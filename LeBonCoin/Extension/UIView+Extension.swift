//
//  UIView+Extension.swift
//  LeBonCoin
//
//  Created by Anis on 17/02/2023.
//

import UIKit

extension UIView {
    func addConstraints(with view: UIView, leading: Int = 0, top: Int = 0, trailing: Int = 0, bottom: Int = 0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(top)).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: CGFloat(leading)).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(bottom)).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: CGFloat(trailing)).isActive = true
    }
}
