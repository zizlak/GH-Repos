//
//  Extensions-UIViewController.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import UIKit

extension UIViewController {
    
    func popUp(message: String) {
        // [df] poor varibale naming
        let ac = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(ok)
        ac.view.tintColor = Colors.tint
        
        self.present(ac, animated: true)
    }
}
