//
//  Groups.swift
//  VK Client
//
//  Created by Сергей Беляков on 08.06.2021.
//
//
//   let groups = try? newJSONDecoder().decode(Groups.self, from: jsonData)

import Foundation

// MARK: - Groups
struct Groups: Codable {
    let response: GroupsResponse
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let id: Int
    let photo100, photo50, photo200: String
    let type: TypeEnum
    let screenName, name: String
    let isClosed: Int
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
        case deactivated
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}
