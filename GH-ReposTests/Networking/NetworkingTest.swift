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
    
    //MARK: - LifeCycle Methods
    override func setUp() {
        super.setUp()
        urlStringRepos = "https://api.github.com/repositories"
        urlRepos = URL(string: urlStringRepos)
    }
    
    override func tearDown() {
        urlStringRepos = nil
        super.tearDown()
    }
    
    //MARK: - ModelURL
    func testURLModelURL() {
        
        let sut = URLModel(scheme: "https",
                           host: "api.github.com",
                           path: ["repositories"])
        
        XCTAssertEqual(sut.url, urlRepos, "URL is not equal to: " + urlStringRepos)
    }
    
    
    func testURLModelURLWithQueryItems() {
        
        let sut = URLModel(scheme: "https",
                           host: "api.github.com",
                           path: ["search", "repositories"],
                           queryItems: [URLQueryItem(name: "q", value: "foo")])
        
        let urlString = "https://api.github.com/search/repositories?q=foo"
        let url = URL(string: urlString)
        
        XCTAssertEqual(sut.url, url, "URL is not equal to https://api.github.com/search/repositories?q=foo")
    }
    
    
    //MARK: - NetworkService
    func testNetworkService() {
        let sut = NetworkService()
        sut.request(url: urlRepos) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail(error.rawValue)
            }
        }
    }
}
