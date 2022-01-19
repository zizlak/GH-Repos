//
//  NetworkService.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// MARK: - Protocol
protocol NetworkRequestServiceProtocol {
    // [df] `NetworkRequestService` is very general whereas it contains `ReposError` which related to repo
    func request(url: URL, completion: @escaping(Result<Data, ReposError>) -> Void)
}

class NetworkRequestService: NetworkRequestServiceProtocol {

    // MARK: - Request
    func request(url: URL, completion: @escaping(Result<Data, ReposError>) -> Void) {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    // MARK: - DataTask
    private func createDataTask(from request: URLRequest,
                                completion: @escaping(Result<Data, ReposError>) -> Void) -> URLSessionDataTask {
        // [df] how we can get more control on `URLSession`: setup it and have multiple sessions?
        return URLSession.shared.dataTask(with: request) { data, response, error in
            // [df] why switch to main?
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
