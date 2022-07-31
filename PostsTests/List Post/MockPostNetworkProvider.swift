//
//  MockPostNetworkProvider.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation
@testable import Posts

struct MockPositivePostNetworkProvider: PostsNetworkProvider {
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void)) {
        let result = MockPostData.generateListPost()
        completion(.success(result))
    }
    
    func fetchListUsers(completion: @escaping ((NetworkResult<[UserModel]>) -> Void)) {
        let result = MockPostData.generateListUsers()
        completion(.success(result))
    }
}

struct MockNegativePostNetworkProvider: PostsNetworkProvider {
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void)) {
        completion(.failed("failed"))
    }
    
    func fetchListUsers(completion: @escaping ((NetworkResult<[UserModel]>) -> Void)) {
        completion(.failed("failed"))
    }
}
