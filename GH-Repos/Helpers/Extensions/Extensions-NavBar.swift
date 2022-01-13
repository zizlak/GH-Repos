//
//  Extensions-NavBar.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//


import UIKit

extension UINavigationBar {
    
    static func setupUI() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = Colors.second
        UINavigationBar.appearance().tintColor = Colors.first
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.third]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.third]
    }
}
