//
//  PostModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import Foundation

struct PostModel: Codable, Equatable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
