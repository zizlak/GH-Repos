//
//  ReposListViewModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import Foundation

// MARK: - Protocol
protocol ReposListViewModelProtocol {
    // [df] init in protocol
    init(listener: (() -> Void)?)

    func numberOfItems() -> Int
    func repoCellViewModel(forIndexPath indexPath: IndexPath) -> RepoCellViewModelProtocol?

    func fetchAllRepos()
    func fetchReposContaining(_ keyword: String?)
    func searchTextDidChangeTo(_ keyword: String?)

    var errorString: Box<String?> { get }
}

// [df] how to check that `ReposListViewModel` uses `ObjectsFetcherManager` properly in tests
class ReposListViewModel: ReposListViewModelProtocol {

    // MARK: - Properties
    typealias Listener = () -> Void

    var reposDidChange: Listener?
    private var repos: [RepoModel] = [] {
        didSet {
            reposDidChange?()
        }
    }
    var errorString: Box<String?> = Box(nil)

    // MARK: - Init
    required init(listener: Listener?) {
        self.reposDidChange = listener
    }

    // MARK: - Methods
    func fetchAllRepos() {
        // [df] ObjectsFetcherManager should be a dependency
        ObjectsFetcherManager().fetchRepos { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let repos):
                self.repos = repos

            case .failure(let error):
                // [df] no box
                self.errorString.value = error.rawValue
            }
        }
    }

    func fetchReposContaining(_ keyword: String?) {
        guard let keyword = keyword else { return }
        guard !keyword.isEmpty else {
            fetchAllRepos()
            return
        }

        // [df] code looks quite similar to `fetchAllRepos`
        ObjectsFetcherManager().fetchReposContaining(keyword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repos):
                guard let items = repos.items else { return }
                self.repos = items

            case .failure(let error):
                // [df] box
                self.errorString = Box(error.rawValue)
            }
        }
    }

    func searchTextDidChangeTo(_ keyword: String?) {
        guard let keyword = keyword else { return }
        if keyword.isEmpty {
            fetchAllRepos()
        }
    }

    func numberOfItems() -> Int {
        repos.count
    }

    func repoCellViewModel(forIndexPath indexPath: IndexPath) -> RepoCellViewModelProtocol? {
        guard repos.count > indexPath.row else { return nil }
        return RepoCellViewModel(repoModel: repos[indexPath.row])
    }
}
