//
//  Extensions-UIViewController.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import UIKit

extension UIViewController {

    func popUp(message: String) {
        // [df] where to store strings?
        let allertController = UIAlertController(title: "Something went wrong",
                                                 message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        allertController.addAction(okAction)
        allertController.view.tintColor = Colors.tint

        self.present(allertController, animated: true)
    }
}
