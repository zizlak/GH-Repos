//
//  RepoCellViewModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import UIKit

// MARK: - Protocol
protocol RepoCellViewModelProtocol: AnyObject {
    var name: String { get }
    var description: String { get }

    var avatar: Box<UIImage?> { get }
    func fetchImage()
}

class RepoCellViewModel: RepoCellViewModelProtocol {

    // MARK: - Constants
    private enum DefaultImages {
        static let defaultAvatar = UIImage(named: "defaultAvatar")
    }
    private enum Strings {
        static let noName = "No Name"
        static let noDescription = "No Description"
    }

    // MARK: - Properties
    private let repoModel: RepoModel

    var name: String {
        let name = repoModel.fullName ?? Strings.noName
        return name.replacingOccurrences(of: "/", with: " ")
    }

    var description: String {
        repoModel.description ?? Strings.noDescription
    }

    var avatar: Box<UIImage?> = Box(nil)

    // MARK: - LifeCycle Methods
    init(repoModel: RepoModel) {
        self.repoModel = repoModel
    }

    // MARK: - Methods
    func fetchImage() {
        let imageURL = repoModel.owner?.avatarUrl
        ImageFetcherManager.shared.fetchImageData(urlString: imageURL) { [weak self] image in
            let avatar = image ?? DefaultImages.defaultAvatar
            self?.avatar.value = avatar
        }
    }
}
