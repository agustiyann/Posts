//
//  DetailPostTest.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import XCTest
@testable import Posts

class DetailPostTest: XCTestCase {
    
    var sut: DetailPostViewController!

    override func setUpWithError() throws {
        sut = DetailPostViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_viewDidLoad_configuresViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func test_viewDidLoad_initialState() {
        XCTAssertEqual(sut.viewModel.listComments.count, 0)
        XCTAssertEqual(sut.viewModel.listComments.count, 0)
    }
    
    func test_positiveDidLoadComments() {
        let useCase = MockPositiveDetailPostNetworkProvider()
        let viewModel = DetailPostViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return post data")
        let resultExpectation = MockDetailPostData.generateListComment()
        
        viewModel.didReceiveComments = {
            let posts = viewModel.listComments
            XCTAssertEqual(posts, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoadComments(postId: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_negativeDidLoadComments() {
        let useCase = MockNegativeDetailPostNetworkProvider()
        let viewModel = DetailPostViewModel(useCase: useCase)
        let expectation = expectation(description: "Should return error")
        
        viewModel.didReceiveErrorComments = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoadComments(postId: 1)
        waitForExpectations(timeout: 1, handler: nil)
    }

}
