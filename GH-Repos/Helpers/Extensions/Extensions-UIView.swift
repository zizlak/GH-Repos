//
//  Extensions-UIView.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

//MARK: - UIView
extension UIView {
    
    func pin(to parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
