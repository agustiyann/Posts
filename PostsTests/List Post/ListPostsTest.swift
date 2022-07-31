//
//  ListPostsTest.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import XCTest
@testable import Posts

class ListPostsTest: XCTestCase {
    
    var sut: ListPostsViewController!

    override func setUpWithError() throws {
        sut = ListPostsViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_viewDidLoad_configuresViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func test_viewDidLoad_initialState() {
        XCTAssertEqual(sut.viewModel.listPosts.count, 0)
        XCTAssertEqual(sut.viewModel.listUsers.count, 0)
    }
    
    // Taks 1 - List Posts
    /// Did receive list posts
    func test_positiveDidLoadPosts() {
        let useCase = MockPositivePostNetworkProvider()
        let viewModel = ListPostsViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return list post data")
        let resultExpectation = MockPostData.generateListPost()
        
        viewModel.didReceivePosts = {
            let posts = viewModel.listPosts
            XCTAssertEqual(posts, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoadPosts()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Did receive error posts
    func test_negativeDidLoadPosts() {
        let useCase = MockNegativePostNetworkProvider()
        let viewModel = ListPostsViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return error")
        
        viewModel.didReceiveErrorPosts = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoadPosts()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Task 2 - List Users
    /// Did receive list users
    func test_positiveDidLoadUsers() {
        let useCase = MockPositivePostNetworkProvider()
        let viewModel = ListPostsViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return list user data")
        let resultExpectation = MockPostData.generateListUsers()
        
        viewModel.didReceiveUsers = {
            let users = viewModel.listUsers
            XCTAssertEqual(users, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoadPosts()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Did receive error users
    func test_negativeDidLoadUsers() {
        let useCase = MockNegativePostNetworkProvider()
        let viewModel = ListPostsViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return error")
        
        viewModel.didReceiveErrorUsers = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoadPosts()
        waitForExpectations(timeout: 1, handler: nil)
    }

}
