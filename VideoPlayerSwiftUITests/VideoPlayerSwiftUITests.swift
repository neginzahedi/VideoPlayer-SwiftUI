//
//  VideoPlayerSwiftUITests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Michael Gauthier on 2021-01-06.
//

import XCTest
@testable import VideoPlayerSwiftUI

class VideoPlayerSwiftUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFetchVideos() async{
        // Given
        let dataManager = VideoManager.shared
        // When
        try? await dataManager.fetchVideos()
        // Then
        XCTAssertNotNil(dataManager.videos)
        XCTAssert(dataManager.videos.capacity > 0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
