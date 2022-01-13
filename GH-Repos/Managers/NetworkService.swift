//
//  NetworkService.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation


protocol NetworkServiceProtocol {
    func request(url: URL, completion: @escaping(Result<Data, ReposError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    //MARK: - Request
    func request(url: URL, completion: @escaping(Result<Data, ReposError>) -> Void) {        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        print("Task Resume")
        task.resume()
    }
    
    //MARK: - DataTask
    private func createDataTask(from request: URLRequest, completion: @escaping(Result<Data, ReposError>) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.unableToComplete))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                          completion(.failure(.invalidResponse))
                          return
                      }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(data))
            }
        }
    }
}
