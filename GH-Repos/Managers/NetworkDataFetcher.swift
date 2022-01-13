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
    var networkService: NetworkServiceProtocol
    
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






//
import UIKit
class ImageDataFetcher {
    
    //MARK: - Dependency
    var networkService: NetworkServiceProtocol
    
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - Methods
    func fetchImageData(urlString: String, completion: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else { return }
        networkService.request(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async { self.image = image }
            case .failure(_):
                break
            }
        }
    }
    
}
