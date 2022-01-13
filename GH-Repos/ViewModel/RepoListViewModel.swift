//
//  RepoListViewModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import Foundation

protocol RepoListViewModelProtocol {
    func numberOfItems() -> Int
    func repoCellViewModel(forIndexPath indexPath: IndexPath) -> RepoCellViewModelProtocol?
    func fetchStories()
}

class RepoListViewModel : RepoListViewModelProtocol {

    //MARK: - Properties
    
    typealias Listener = () -> ()
    
    var listener: Listener?
    var repos: [RepoModel] = [] {
        didSet {
            listener?()
        }
    }
    
    
    //MARK: - LifeCycle Methods
    
    init(listener: Listener?) {
        self.listener = listener
    }
    
    //MARK: - Methods
    
    func fetchStories() {
        DataFetcherService().fetchRepos() { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func numberOfItems() -> Int {
        repos.count
    }
    
    func repoCellViewModel(forIndexPath indexPath: IndexPath) -> RepoCellViewModelProtocol? {
        guard repos.count >= indexPath.row else { return nil }
        return RepoCellViewModel(repoModel: repos[indexPath.row])
    }
}
