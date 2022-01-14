//
//  RepoCellViewModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import UIKit

protocol RepoCellViewModelProtocol: AnyObject {
    var name : String { get }
    var description : String { get }
    
    var avatar: Box<UIImage?> { get }
}

class RepoCellViewModel: RepoCellViewModelProtocol {

    //MARK: - Properties
    let repoModel: RepoModel
    
    var name: String {
        let name = repoModel.full_name ?? Constants.RepoCell.noName
        return name.replacingOccurrences(of: "/", with: " ")
    }
    
    var description: String {
        repoModel.description ?? Constants.RepoCell.noDescription
    }
    
    var avatar: Box<UIImage?> = Box(nil)
    
    
    //MARK: - LifeCycle Methods
    init(repoModel: RepoModel) {
        self.repoModel = repoModel
        fetchImage()
    }
    
    //MARK: - Methods
    func fetchImage() {
        let imageURL = repoModel.owner?.avatar_url
        ImageFetcher.shared.fetchImageData(urlString: imageURL) { [weak self] image in
            guard let image = image else {
                self?.avatar.value = Constants.defaultAvatar
                return
            }
            self?.avatar.value = image
        }
    }

}
