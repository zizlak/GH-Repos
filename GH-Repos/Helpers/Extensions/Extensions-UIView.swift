//
//  Extensions-UIView.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

//MARK: - UIView
extension UIView {
    
    func pin(to parentView: UIView, with padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            self.leadingAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            self.bottomAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
