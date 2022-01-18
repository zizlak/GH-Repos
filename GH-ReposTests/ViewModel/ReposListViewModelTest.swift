//
//  ReposListViewModelTest.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class ReposListViewModelTest: XCTestCase {

    var keyword = "swift"

    // MARK: - Tests
    func testInitReposListViewModel() {
        let viewModel = MockReposListViewModel(listener: nil)
        XCTAssertNotNil(viewModel)
    }

    // MARK: - FetchAllRepos()
    func testFetchAllReposUpdatesRepos() {
        var didReposUpdate = false
        let promise = expectation(description: "Fetch all repos")

        let viewModel = MockReposListViewModel {
            didReposUpdate = true
            promise.fulfill()
        }
        viewModel.fetchAllRepos()

        waitForExpectations(timeout: 1) {_ in
            XCTAssertTrue(didReposUpdate, "Repos should be updated after fetchAllRepos()")
        }
        XCTAssertTrue(viewModel.fetchAllReposCalled,
                      "fetchAllRepos should be called")
    }

    // MARK: - fetchReposContaining()
    func testFetchReposByKeyword() {
        var didReposUpdate = false
        let promise = expectation(description: "Fetch repos by keyword")

        let viewModel = MockReposListViewModel {
            didReposUpdate = true
            promise.fulfill()
        }
        viewModel.fetchReposContaining(keyword)

        waitForExpectations(timeout: 1) {_ in
            XCTAssertTrue(didReposUpdate, "Repos should be updated after fetchReposContaining(keyword)")
        }

        XCTAssertFalse(viewModel.fetchAllReposCalled,
                       "fetchAllRepos should not be called if keyword is not empty")
    }

    func testFetchReposByKeywordNil() {
        var didReposUpdate = false
        let promise = expectation(description: "Fetch repos by keyword nil")
        promise.isInverted = true

        let viewModel = MockReposListViewModel {
            didReposUpdate = true
            promise.fulfill()
        }
        viewModel.fetchReposContaining(nil)

        waitForExpectations(timeout: 2) {_ in
            XCTAssertFalse(didReposUpdate,
                           "closure schould not be called if keyword is nil")
        }
        XCTAssertFalse(viewModel.fetchAllReposCalled,
                       "fetchAllRepos should not be called if keyword is nil")
    }

    func testFetchReposByEmptyKeyword() {
        let viewModel = MockReposListViewModel(listener: nil)
        viewModel.fetchReposContaining("")

        XCTAssertTrue(viewModel.fetchAllReposCalled,
                      "fetchAllRepos should be called if keyword is empty")

    }

    // MARK: - SearchTextDidChangeTo
    func testSearchTextDidChangeToEmpty() {
        let viewModel = MockReposListViewModel(listener: nil)
        viewModel.searchTextDidChangeTo("")

        XCTAssertTrue(viewModel.fetchAllReposCalled,
                      "fetchAllRepos should be called if keyword is empty")

    }

    func testSearchTextDidChangeToNewKeyword() {
        let promise = expectation(description: "Repos shuld not be updated if keyword is not empty")
        promise.isInverted = true

        let viewModel = MockReposListViewModel {
            promise.fulfill()
        }
        viewModel.searchTextDidChangeTo(keyword)

        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(viewModel.fetchAllReposCalled,
                           "fetchAllRepos should be called if keyword is empty")
        }
    }

    // MARK: - Number Of Items
    func testNumberOfItems() {
        let promise = expectation(description: "Number Of Items")

        var number: Int? {
            viewModel.numberOfItems()
        }

        let viewModel = MockReposListViewModel {
            promise.fulfill()
        }
        viewModel.fetchAllRepos()

        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(number, "Number Of Items should not be nil after fetchAllRepos()")
            XCTAssert(number != 0, "Number Of Items should not be 0 after fetchAllRepos()")
            XCTAssert(number == 100, "Number Of Items should be 100 after fetchAllRepos()")
        }
    }
}

// MARK: - MockObject
extension ReposListViewModelTest {
    class MockReposListViewModel: ReposListViewModel {

        var fetchAllReposCalled = false

        override func fetchAllRepos() {
            super.fetchAllRepos()
            fetchAllReposCalled = true
        }
    }
}
