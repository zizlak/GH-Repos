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

    func fetchImage(completion: @escaping(UIImage?) -> Void)
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
    
    //MARK: - Methods
    func fetchImage(completion: @escaping(UIImage?) -> Void) {
        let imageURL = repoModel.owner?.avatar_url
        ImageFetcher.shared.fetchImageData(urlString: imageURL) { image in
            guard let image = image else {
                completion(Constants.defaultImage)
                return
            }
            completion(image)
        }
    }
    
    
    //MARK: - LifeCycle Methods
    init(repoModel: RepoModel) {
        self.repoModel = repoModel
    }
}
