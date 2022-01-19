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
        guard let repoModel = RepoModel(fullName: "Bar/Baz") else { return }
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        XCTAssert(sut.name == "Bar Baz", "name schould be == Bar Baz")
    }

    // MARK: - Description
    func testRepoCellViewModelDescriptionExists() {
        guard let repoModel = RepoModel(description: "Foo") else { return }
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        XCTAssert(sut.description == "Foo", "name schould be = Foo")
    }

    // MARK: - Default Values
    func testRepoCellViewModelParametersAreDefaults() {

        enum Strings {
            static let noName = "No Name"
            static let noDescription = "No Description"
        }

        guard let repoModel = RepoModel() else { return }
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)

        XCTAssert(sut.description == Strings.noDescription, "name schould be = \(Strings.noDescription)")
        XCTAssert(sut.name == Strings.noName, "name schould be = \(Strings.noName)")
    }
}
