//
//  URLModelTest.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class URLModelTest: XCTestCase {

    var urlStringRepos: String!
    var urlRepos: URL!

    // MARK: - LifeCycle Methods
    override func setUp() {
        super.setUp()
        urlStringRepos = "https://api.github.com/repositories"
        urlRepos = URL(string: urlStringRepos)
    }

    override func tearDown() {
        urlRepos = nil
        urlStringRepos = nil
        super.tearDown()
    }

    // MARK: - ModelURL
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
}
