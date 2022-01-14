//
//  ImageFetcher.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//


import UIKit
class ImageFetcher {
    
    //MARK: - Dependency
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Singeltone
    static let shared = ImageFetcher()
    private init() {}
    
    
    //MARK: - Methods
    func fetchImageData(urlString: String?, completion: @escaping(UIImage?) -> Void) {
        
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
                  completion(nil)
                  return
              }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        networkService.request(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async { completion(image) }
            case .failure(_):
                DispatchQueue.main.async { completion(nil) }
            }
        }
    }
}
