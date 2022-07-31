//
//  MockDetailPostNetworkProvider.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation
@testable import Posts

struct MockPositiveDetailPostNetworkProvider: DetailPostNetworkProvider {
    func fetchPostComments(postID: Int, completion: @escaping ((NetworkResult<[CommentModel]>) -> Void)) {
        let result = MockDetailPostData.generateListComment()
        completion(.success(result))
    }
}

struct MockNegativeDetailPostNetworkProvider: DetailPostNetworkProvider {
    func fetchPostComments(postID: Int, completion: @escaping ((NetworkResult<[CommentModel]>) -> Void)) {
        completion(.failed("failed"))
    }
}
