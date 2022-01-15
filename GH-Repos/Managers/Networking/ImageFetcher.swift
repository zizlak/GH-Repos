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
        
        guard let urlString = urlString else {
            completion(nil)
            return
        }
        
        if let image = getImageFromCache(for: urlString) {
            completion(image)
            return
        }
        requestImageFrom(urlString, completion: completion)
    }
    
    private func requestImageFrom(_ urlString: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        networkService.request(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.saveImageToCache(image: image, for: urlString)
                
                completion(image)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getImageFromCache(for key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        return cache.object(forKey: cacheKey)
    }
    
    private func saveImageToCache(image: UIImage, for key: String) {
        let cacheKey = NSString(string: key)
        cache.setObject(image, forKey: cacheKey)
    }
}
