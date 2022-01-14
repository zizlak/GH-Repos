//
//  GH_ReposTests.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import XCTest
@testable import GH_Repos

class GH_ReposTests: XCTestCase {
    //
    //    override func setUpWithError() throws {
    //    }
    //
    //    override func tearDownWithError() throws {
    //    }
    //
    //    func testExample() throws {
    //
    //    }
    
    //    func testPerformanceExample() throws {
    //        self.measure {
    //        }
    //    }
    
    //MARK: - Name
    func testRepoCellViewModelNameExists() {
        let repoModel = RepoModel(full_name: "Boo/Baz")
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)
        
        XCTAssert(sut.name == "Boo Baz", "name schould be == Boo Baz")
    }
    
    func testRepoCellViewModelNameNotExist() {
        let repoModel = RepoModel()
        let name = Constants.RepoCell.noName
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)
        
        XCTAssert(sut.name == name, "name schould be == \(name)")
    }
    
    
    //MARK: - Description
    func testRepoCellViewModelDescriptionExists() {
        let repoModel = RepoModel(description: "Foo")
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)
        
        XCTAssert(sut.description == "Foo", "name schould be == Foo")
    }
    
    func testRepoCellViewModelDescriptionNotExist() {
        let repoModel = RepoModel()
        let description = Constants.RepoCell.noDescription
        let sut: RepoCellViewModelProtocol = RepoCellViewModel(repoModel: repoModel)
        
        XCTAssert(sut.description == description, "name schould be == \(description)")
    }
    
}
