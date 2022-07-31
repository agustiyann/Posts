//
//  UserModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable, Equatable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable, Equatable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable, Equatable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable, Equatable {
    let name, catchPhrase, bs: String
}
