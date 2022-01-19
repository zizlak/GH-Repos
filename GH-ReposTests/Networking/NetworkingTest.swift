//
//  NetworkingTest.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class NetworkingTest: XCTestCase {

    var urlStringRepos: String!
    var urlRepos: URL!
    var keyWord: String!

    // MARK: - LifeCycle Methods
    override func setUp() {
        super.setUp()
        urlStringRepos = "https://api.github.com/repositories"
        urlRepos = URL(string: urlStringRepos)
        keyWord = "swift"
    }

    override func tearDown() {
        urlStringRepos = nil
        keyWord = nil
        urlRepos = nil
        super.tearDown()
    }

    // MARK: - NetworkService
    func testNetworkServiceRequestDataNotNil() {
        let sut = NetworkRequestService()
        let promise = expectation(description: "Request Data")

        // [df] what are drowbacks of using real requests?
        sut.request(url: urlRepos) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "data schuldn't be nil")
                promise.fulfill()
            case .failure(let error):
                XCTFail(error.rawValue)
            }
        }
        waitForExpectations(timeout: 1)
    }

    func testNetworkServiceUnableToComplete() {
        let sut = NetworkRequestService()
        let brokenURLString = "https://api.github.c/repositories"
        let brokenURL = URL(string: brokenURLString)!
        let promise = expectation(description: "Request Data")
        sut.request(url: brokenURL) { result in
            switch result {
            case .success:
                XCTFail("Data schould be nil")
            case .failure(let error):
                XCTAssertTrue(error == .unableToComplete, "Error schould be unableToComplete")
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }

    func testNetworkObjectsFetcherWithRepos() {
        let sut = NetworkObjectsFetcher()
        let promise = expectation(description: "Fetching RepoModel JSON Data")

        let completion: (Result<[RepoModel], NetworkError>) -> Void = { result in
            switch result {
            case .success(let repos):
                XCTAssertNotNil(repos, "repos schouldn't be nil")
                XCTAssertFalse(repos.isEmpty, "repos schould be not empty")
                promise.fulfill()

            case .failure(let error):
                XCTFail(error.rawValue)
            }
        }
        sut.fetchGenericJSONData(url: urlRepos, completion: completion)
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testNetworkObjectsFetcherWithFilteredRepos() {
        let sut = NetworkObjectsFetcher()
        let promise = expectation(description: "Fetching Filtered Repos JSON Data")

        let urlString = "https://api.github.com/search/repositories?q=" + keyWord
        guard let url = URL(string: urlString) else {
            XCTFail("URL incorrect")
            return
        }

        let completion: (Result<FilteredRepos, NetworkError>) -> Void = { result in
            switch result {
            case .success(let result):
                XCTAssertNotNil(result.items, "repos schouldn't be nil")
                XCTAssertTrue(result.items!.count > 10, "items schould be > 10")
                promise.fulfill()

            case .failure(let error):
                XCTFail(error.rawValue)
            }
        }
        sut.fetchGenericJSONData(url: url, completion: completion)
        waitForExpectations(timeout: 2)
    }
}
