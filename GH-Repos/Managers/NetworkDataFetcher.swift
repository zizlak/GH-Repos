//
//  NetworkDataFetcher.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

protocol DataFetcherProtocol {
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping(Result<T, ReposError>) -> Void)
}

class NetworkDataFetcher: DataFetcherProtocol {
    
    //MARK: - Dependency
    private var networkService: NetworkServiceProtocol
    
    //MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    
    //MARK: - fetchJSONData
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping(Result<T, ReposError>) -> Void) {
        
        networkService.request(url: url) { result in
            switch result {
            case .success(let data):
                guard  let objects = self.decodeJSON(type: T.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(objects))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - decodeJSON
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        let objects = try? decoder.decode(T.self, from: data)
        return objects
    }
}



