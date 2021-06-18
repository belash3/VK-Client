//
//  Groups.swift
//  VK Client
//
//  Created by Сергей Беляков on 08.06.2021.
//
//
//   let groups = try? newJSONDecoder().decode(Groups.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Groups
class Groups: Decodable {
    let response: GroupsResponse

    init(response: GroupsResponse) {
        self.response = response
    }
}

// MARK: - Response
class GroupsResponse: Decodable {
    let count: Int
    let items: [Group]

    init(count: Int, items: [Group]) {
        self.count = count
        self.items = items
    }
}

// MARK: - Item
class Group: Object, Decodable {
    @objc dynamic var isMember = 0
    @objc dynamic var id = 0
    @objc dynamic var photo100 = ""
    @objc dynamic var isAdvertiser = 0
    @objc dynamic var isAdmin = 0
    @objc dynamic var photo50 = ""
    @objc dynamic var photo200 = ""
    @objc dynamic var screenName = ""
    @objc dynamic var name = ""
    @objc dynamic var isClosed = 0

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let groupValues = try decoder.container(keyedBy: CodingKeys.self)
        self.isMember = try groupValues.decode(Int.self, forKey: .isMember)
        self.id = try groupValues.decode(Int.self, forKey: .id)
        self.photo100 = try groupValues.decode(String.self, forKey: .photo100)
        self.isAdvertiser = try groupValues.decode(Int.self, forKey: .isAdvertiser)
        self.isAdmin = try groupValues.decode(Int.self, forKey: .isAdmin)
        self.photo50 = try groupValues.decode(String.self, forKey: .photo50)
        self.photo200 = try groupValues.decode(String.self, forKey: .photo200)
        self.screenName = try groupValues.decode(String.self, forKey: .screenName)
        self.name = try groupValues.decode(String.self, forKey: .name)
        self.isClosed = try groupValues.decode(Int.self, forKey: .isClosed)
    }
//    init(isMember: Int, id: Int, photo100: String, isAdvertiser: Int, isAdmin: Int, photo50: String, photo200: String, screenName: String, name: String, isClosed: Int) {
//        self.isMember = isMember
//        self.id = id
//        self.photo100 = photo100
//        self.isAdvertiser = isAdvertiser
//        self.isAdmin = isAdmin
//        self.photo50 = photo50
//        self.photo200 = photo200
//        self.screenName = screenName
//        self.name = name
//        self.isClosed = isClosed
//    }
    
}
