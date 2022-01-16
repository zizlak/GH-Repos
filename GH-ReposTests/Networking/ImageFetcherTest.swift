//
//  ImageFetcherTest.swift
//  GH-ReposTests
//
//  Created by Aleksandr Kurdiukov on 15.01.22.
//

import XCTest
@testable import GH_Repos

class ImageFetcherTest: XCTestCase {
    
    var avatarURLString: String!
    var sut: ImageFetcher!
    
    //MARK: - LifeCycle Methods
    override func setUp() {
        super.setUp()
        sut = MockImageFetcher.shared
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
        waitForExpectations(timeout: 1) { [unowned self] _ in
            let object = self.sut.getImageFromCache(for: self.avatarURLString)
            XCTAssertNotNil(object, "Object from cache schould not be nil")
        }
    }
}


//MARK: - MockObject
extension ImageFetcherTest {
    class MockImageFetcher: ImageFetcher {
    }
}
