//
//  RepoModelTests.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

// [df] what is point of testing model objects?
class RepoModelTests: XCTestCase {

    // MARK: - Init
    func testInitRepoModel() {

        let sut = RepoModel(fullName: "Foo", description: "Bar")
        guard let sut = sut else { XCTFail("RepoModel is nil"); return }

        XCTAssert(sut.fullName == "Foo", "fullName schould be Foo")
        XCTAssert(sut.description == "Bar", "description schould be Bar")
        XCTAssert(sut.owner?.avatarUrl == nil, "avatarUrl should be nil")
    }

    func testInitRepoModelToNilValues() {

        let sut = RepoModel()

        XCTAssert(sut == nil, "RepoModel should be nil")
        XCTAssertNil(sut?.fullName, "fullName schould be nil")
        XCTAssertNil(sut?.description, "description schould be nil")
        XCTAssertNil(sut?.owner?.avatarUrl, "avatarUrl should be nil")
    }

    func testInitRepoModelToNilValuesMemberwiseInit() {

        let sut = RepoModel(fullName: nil, description: nil, owner: nil)

        XCTAssert(sut == nil, "RepoModel should be nil")
        XCTAssertNil(sut?.fullName, "fullName schould be nil")
        XCTAssertNil(sut?.description, "description schould be nil")
        XCTAssertNil(sut?.owner?.avatarUrl, "avatarUrl should be nil")
    }

    // MARK: - FilteredRepos
    func testFilteredRepos() {

        guard let repoModel = RepoModel(owner: Owner(avatarUrl: "Baz")) else {
            XCTFail("RepoModel is nil"); return }

        let sut = FilteredRepos(items: [repoModel])

        XCTAssert(sut.items?.count == 1, "items.count should be 1")
        XCTAssert(sut.items?[0].owner?.avatarUrl == "Baz", "avatarUrl should be Baz")
    }
}
