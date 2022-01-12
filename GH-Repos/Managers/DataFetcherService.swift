//
//  DataFetcherService.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

class DataFetcherService {
    
    //MARK: - Dependency
    var networkDataFetcher: DataFetcherProtocol
    
    
    //MARK: - Init
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    //MARK: - fetchRepos
    func fetchRepos(completion: @escaping(Result<[RepoModel], ReposError>) -> Void) {
        let urlModel = URLModel(scheme: "https",
                                host: "api.github.com",
                                path: ["/repositories"])
        guard let url = urlModel.url else { return }
        
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
    
}

