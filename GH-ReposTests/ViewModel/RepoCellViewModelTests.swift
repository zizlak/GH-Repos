//
//  RepoCellViewModelTests.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import XCTest
@testable import GH_Repos

// [df] what is point of testing view-models?
class RepoCellViewModelTests: XCTestCase {

    // MARK: - Name
    func testRepoCellViewModelNameExists() {
        let repoModel = RepoModel(fullName: "Bar/Baz")
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        XCTAssert(sut.name == "Bar Baz", "name schould be == Bar Baz")
    }

    // MARK: - Description
    func testRepoCellViewModelDescriptionExists() {
        let repoModel = RepoModel(description: "Foo")
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        XCTAssert(sut.description == "Foo", "name schould be = Foo")
    }

    // MARK: - Default Values
    func testRepoCellViewModelParametersAreDefaults() {
        let repoModel = RepoModel()
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        let name = Constants.RepoCell.noName
        let description = Constants.RepoCell.noDescription

        XCTAssert(sut.description == description, "name schould be = \(description)")
        XCTAssert(sut.name == name, "name schould be = \(name)")
    }
}
