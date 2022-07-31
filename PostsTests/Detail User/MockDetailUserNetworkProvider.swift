//
//  MockDetailUserNetworkProvider.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation
@testable import Posts

struct MockPositiveDetailUserNetworkProvider: DetailUserNetworkProvider {
    func fetchUserAlbums(userId: Int, completion: @escaping ((NetworkResult<[AlbumModel]>) -> Void)) {
        let result = MockDetailUserData.generateListAlbums()
        completion(.success(result))
    }
    
    func fetchAlbumPhotos(albumID: Int, completion: @escaping ((NetworkResult<[PhotoModel]>) -> Void)) {
        let result = MockDetailUserData.generateAlbumPhotos()
        completion(.success(result))
    }
}

struct MockNegativeDetailUserNetworkProvider: DetailUserNetworkProvider {
    func fetchUserAlbums(userId: Int, completion: @escaping ((NetworkResult<[AlbumModel]>) -> Void)) {
        completion(.failed("failed"))
    }
    
    func fetchAlbumPhotos(albumID: Int, completion: @escaping ((NetworkResult<[PhotoModel]>) -> Void)) {
        completion(.failed("failed"))
    }
}
