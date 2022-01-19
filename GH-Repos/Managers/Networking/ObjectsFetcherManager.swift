//
//  DataFetcherService.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// [df] how about protocol for this class?

// MARK: - Protocol
protocol ObjectsFetcherManagerProtocol {

    func fetchRepos(completion: @escaping(Result<[RepoModel], NetworkError>) -> Void)
    func fetchReposContaining(_ keyword: String, completion: @escaping(Result<FilteredRepos, NetworkError>) -> Void)
}

class ObjectsFetcherManager: ObjectsFetcherManagerProtocol {

    // MARK: - Dependency
    private var networkDataFetcher: ObjectsFetcherProtocol

        // MARK: - Constants

    private enum URLConstants {
        static let scheme = "https"
        static let host = "api.github.com"
        static let pathForAllRepos = ["repositories"]
        static let pathForSearch = ["search", "repositories"]
        static let queryItemForKeyword = "q"
    }

    // MARK: - Init
    init(networkDataFetcher: ObjectsFetcherProtocol = NetworkObjectsFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }

    // MARK: - fetchRepos
    func fetchRepos(completion: @escaping(Result<[RepoModel], NetworkError>) -> Void) {
        // [df] should use constants
        let urlModel = URLModel(scheme: URLConstants.scheme,
                                host: URLConstants.host,
                                path: URLConstants.pathForAllRepos)
        guard let url = urlModel.url else { return }

        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }

    // MARK: - Repos by keyword
    func fetchReposContaining(_ keyword: String, completion: @escaping(Result<FilteredRepos, NetworkError>) -> Void) {
        // [df] seems like both methods look quite similar
        let urlModel = URLModel(scheme: URLConstants.scheme,
                                host: URLConstants.host,
                                path: URLConstants.pathForSearch,
                                queryItems: [URLQueryItem(name: URLConstants.queryItemForKeyword, value: keyword)]
        )
        guard let url = urlModel.url else { return }

        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
}
