//
//  Friends.swift
//  VK Client
//
//  Created by Сергей Беляков on 07.06.2021.
//

import Foundation

// MARK: - Friends
struct Friends: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [User]
}

// MARK: - Item
struct User: Codable {
    let canAccessClosed: Bool?
    let id: Int
    let photo100: String
    let lastName, trackCode: String
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
    }
}
