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
    
    func fetchAllRepos()
    func fetchReposContaining(_ keyword: String) -> Void
    func searchTextDidChange(to keyword: String) -> Void
    
    var error: Box<String?> {get set}
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
    var error: Box<String?> = Box(nil)
    
    
    //MARK: - Init
    init(listener: Listener?) {
        self.listener = listener
    }
    
    //MARK: - Methods
    func fetchAllRepos() {
        DataFetcherService().fetchRepos() { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func fetchReposContaining(_ keyword: String) {
        guard !keyword.isEmpty else { fetchAllRepos(); return }
        DataFetcherService().fetchReposContaining(keyword) { [weak self] result in
            switch result {
            case .success(let repos):
                guard let items = repos.items else { return }
                self?.repos = items
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func searchTextDidChange(to keyword: String) {
        if keyword.isEmpty {
            fetchAllRepos()
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
