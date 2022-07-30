//
//  AlbumModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation

struct AlbumModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
