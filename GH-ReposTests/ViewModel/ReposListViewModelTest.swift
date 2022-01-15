//
//  ReposListViewModelTest.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class ReposListViewModelTest: XCTestCase {
    
    func testInitReposListViewModel() {
        let viewModel = MockReposListViewModel(listener: nil)
        XCTAssertNotNil(viewModel)
    }
}


//MARK: - MockObject
extension ReposListViewModelTest {
    class MockReposListViewModel: ReposListViewModel {
        
    }
}
