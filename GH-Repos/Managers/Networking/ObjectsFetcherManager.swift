//
//  DataFetcherService.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// [df] how about protocol for this class?
class ObjectsFetcherManager {
    
    //MARK: - Dependency
    private var networkDataFetcher: ObjectsFetcherProtocol
    
    //MARK: - Init
    init(networkDataFetcher: ObjectsFetcherProtocol = NetworkObjectsFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    //MARK: - fetchRepos
    func fetchRepos(completion: @escaping(Result<[RepoModel], ReposError>) -> Void) {
        // [df] should use constants
        let urlModel = URLModel(scheme: "https",
                                host: "api.github.com",
                                path: ["repositories"])
        guard let url = urlModel.url else { return }
        
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
    
    //MARK: - Repos by keyword
    func fetchReposContaining(_ keyword: String, completion: @escaping(Result<FilteredRepos, ReposError>) -> Void) {
        // [df] seems like both methods look quite similar
        let urlModel = URLModel(scheme: "https",
                                host: "api.github.com",
                                path: ["search", "repositories"],
                                queryItems: [URLQueryItem(name: "q", value: keyword)]
        )
        guard let url = urlModel.url else { return }
        
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
}

