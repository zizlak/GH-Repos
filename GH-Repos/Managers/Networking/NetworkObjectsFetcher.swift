//
//  NetworkDataFetcher.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// MARK: - Protocol
protocol ObjectsFetcherProtocol {
    // [df] same as `NetworkRequestServiceProtocol`
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping(Result<T, NetworkError>) -> Void)
}

// [df] idea for a test: how to check that `NetworkObjectsFetcher` properly uses `networkService`?
// [df] tests all other
class NetworkObjectsFetcher: ObjectsFetcherProtocol {

    // MARK: - Dependency
    private var networkService: NetworkRequestServiceProtocol

    // MARK: - Init
    init(networkService: NetworkRequestServiceProtocol = NetworkRequestService()) {
        self.networkService = networkService
    }

    // MARK: - fetchJSONData
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {

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

    // MARK: - Decode JSON
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let objects = try? decoder.decode(T.self, from: data)
        return objects
    }
}
