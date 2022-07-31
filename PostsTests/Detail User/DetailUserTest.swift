//
//  DetailUserTest.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import XCTest
@testable import Posts

class DetailUserTest: XCTestCase {
    
    var sut: DetailUserViewController!
    var sut2: AlbumTableViewCell!

    override func setUpWithError() throws {
        sut = DetailUserViewController()
        sut2 = AlbumTableViewCell()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        sut2 = nil
    }
    
    func test_didLoad_configureViewModel() {
        XCTAssertNotNil(sut.viewModel)
        XCTAssertNotNil(sut2.viewModel)
    }
    
    func test_viewDidLoad_initialState() {
        XCTAssertEqual(sut.viewModel.listAlbums.count, 0)
        XCTAssertEqual(sut2.viewModel.listPhotos.count, 0)
    }
    
    // Receive list albums
    func test_positiveDidLoadAlbums() {
        let useCase = MockPositiveDetailUserNetworkProvider()
        let viewModel = DetailUserViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return list albums")
        let resultExpectation = MockDetailUserData.generateListAlbums()
        
        viewModel.didReceiveAlbums = {
            let albums = viewModel.listAlbums
            XCTAssertEqual(albums, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoadAlbums(userID: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Receive error albums
    func test_negativeDidLoadAlbums() {
        let useCase = MockNegativeDetailUserNetworkProvider()
        let viewModel = DetailUserViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return error")
        
        viewModel.didReceiveErrorAlbums = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoadAlbums(userID: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Receive album photos
    func test_positiveDidLoadAlbumPhotos() {
        let useCase = MockPositiveDetailUserNetworkProvider()
        let viewModel = AlbumViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return list albums")
        let resultExpectation = MockDetailUserData.generateAlbumPhotos()
        
        viewModel.didReceivePhotos = {
            let photos = viewModel.listPhotos
            XCTAssertEqual(photos, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoadAlbums(albumID: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Receive error photos
    func test_negativeDidLoadAlbumPhotos() {
        let useCase = MockNegativeDetailUserNetworkProvider()
        let viewModel = AlbumViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return error")
        
        viewModel.didReceiveErrorPhotos = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoadAlbums(albumID: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }

}
