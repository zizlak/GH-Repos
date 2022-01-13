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
    var image : UIImage? { get }
}

class RepoCellViewModel: RepoCellViewModelProtocol {

    //MARK: - Properties
    let repoModel: RepoModel
    
    var name: String {
        let name = repoModel.full_name ?? "No Title"
        return name.replacingOccurrences(of: "/", with: " ")
    }
    
    var description: String {
        repoModel.description ?? "No Description"
    }
    
    var image: UIImage? {
        return UIImage(systemName: "heart")
    }
    
    
    //MARK: - LifeCycle Methods
    init(repoModel: RepoModel) {
        self.repoModel = repoModel
    }
}
