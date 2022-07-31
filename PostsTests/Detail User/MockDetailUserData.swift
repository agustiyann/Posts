//
//  MockAlbumModel.swift
//  PostsTests
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation
@testable import Posts

struct MockDetailUserData {
    
    static func generateListAlbums() -> [AlbumModel] {
        return [
            AlbumModel(userID: 1, id: 1, title: "quidem molestiae enim"),
            AlbumModel(userID: 1, id: 2, title: "sunt qui excepturi placeat culpa"),
            AlbumModel(userID: 1, id: 3, title: "omnis laborum odio"),
            AlbumModel(userID: 1, id: 4, title: "non esse culpa molestiae omnis sed optio"),
            AlbumModel(userID: 1, id: 5, title: "eaque aut omnis a"),
        ]
    }
    
    static func generateAlbumPhotos() -> [PhotoModel] {
        return [
            PhotoModel(
                albumID: 1,
                id: 1,
                title: "accusamus beatae ad facilis cum similique qui sunt",
                url: "https://via.placeholder.com/600/92c952",
                thumbnailURL: "https://via.placeholder.com/150/92c952"),
            PhotoModel(
                albumID: 1,
                id: 2,
                title: "reprehenderit est deserunt velit ipsam",
                url: "https://via.placeholder.com/600/771796",
                thumbnailURL: "https://via.placeholder.com/150/771796"),
            PhotoModel(
                albumID: 1,
                id: 3,
                title: "officia porro iure quia iusto qui ipsa ut modi",
                url: "https://via.placeholder.com/600/24f355",
                thumbnailURL: "https://via.placeholder.com/150/24f355"),
        ]
    }
    
}
