//
//  TestImageFetcher.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class TestImageFetcher: XCTestCase {
    
    var avatarURLString: String!
    var sut: ImageFetcher!
    
    //MARK: - LifeCycle Methods
    override func setUp() {
        super.setUp()
        sut = MockTestImageFetcher.shared
        avatarURLString = "https://avatars.githubusercontent.com/u/128?v=4"
    }
    
    override func tearDown() {
        avatarURLString = nil
        sut = nil
        super.tearDown()
    }
    
    
    //MARK: - Tests
    func testImageNotNil() {
        let promise = expectation(description: "Fetch Image")
        var image: UIImage?
        sut.fetchImageData(urlString: avatarURLString) { downloadedImage in
            image = downloadedImage
            promise.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(image, "Returned image schould not be nil")
        }
    }
    
    func testImageSavedToCache() {
        let promise = expectation(description: "Fetch Image")
        sut.fetchImageData(urlString: avatarURLString) { _ in
            promise.fulfill()
        }
        waitForExpectations(timeout: 1) { [weak self] _ in
            guard let self = self else { XCTFail("Self is nil"); return }
            
            let object = self.sut.getImageFromCache(for: self.avatarURLString)
            XCTAssertNotNil(object, "Object from cache schould not be nil")
        }
    }
}


extension TestImageFetcher {
    class MockTestImageFetcher: ImageFetcher {
    }
}
