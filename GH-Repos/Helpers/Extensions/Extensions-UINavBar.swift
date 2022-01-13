//
//  Extensions-UINavBar.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//


import UIKit

extension UINavigationBar {
    
    static func setupUI() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = Colors.backGround
        UINavigationBar.appearance().tintColor = Colors.tint
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.text]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.text]
    }
}
