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
    
    var errorString: Box<String?> {get set}
}

class RepoListViewModel : RepoListViewModelProtocol {

    //MARK: - Properties
    typealias Listener = () -> ()
    
    var reposDidChange: Listener?
    private var repos: [RepoModel] = [] {
        didSet {
            reposDidChange?()
        }
    }
    var errorString: Box<String?> = Box(nil)
    
    
    //MARK: - Init
    init(listener: Listener?) {
        self.reposDidChange = listener
    }
    
    //MARK: - Methods
    func fetchAllRepos() {
        DataFetcherService().fetchRepos() { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                
            case .failure(let error):
                self?.errorString.value = error.rawValue
            }
        }
    }
    
    func fetchReposContaining(_ keyword: String) {
        guard !keyword.isEmpty else {
            fetchAllRepos()
            return
        }
        
        DataFetcherService().fetchReposContaining(keyword) { [weak self] result in
            switch result {
            case .success(let repos):
                guard let items = repos.items else { return }
                self?.repos = items
                
            case .failure(let error):
                self?.errorString = Box(error.rawValue)
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
