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

    // MARK: - Properties
    private let repoModel: RepoModel

    var name: String {
        let name = repoModel.fullName ?? Constants.RepoCell.noName
        return name.replacingOccurrences(of: "/", with: " ")
    }

    var description: String {
        repoModel.description ?? Constants.RepoCell.noDescription
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
            let avatar = image ?? Constants.defaultAvatar
            self?.avatar.value = avatar
        }
    }
}
