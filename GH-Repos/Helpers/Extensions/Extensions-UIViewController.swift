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

        enum ErrorStrings {
            static let errorTitle = "Something went wrong"
            static let okString = "OK"
        }

        let allertController = UIAlertController(title: ErrorStrings.errorTitle,
                                                 message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ErrorStrings.okString, style: .cancel)
        allertController.addAction(okAction)
        allertController.view.tintColor = Colors.tint

        self.present(allertController, animated: true)
    }
}
