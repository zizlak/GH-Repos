//
//  Constants.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

enum Constants {

    static let defaultAvatar = UIImage(named: "defaultAvatar")
    static let repositoriesString = "Repositories"

    // MARK: - RepoCell
    struct RepoCell {
        static let noName = "No Name"
        static let noDescription = "No Description"
    }

    // MARK: - Sizes
    struct Sizes {
        static let cellAvatarWidth: CGFloat = 60
        static let standartPadding: CGFloat = 5
    }
}
