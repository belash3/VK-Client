//
//  Friends.swift
//  VK Client
//
//  Created by Сергей Беляков on 07.06.2021.
//

import Foundation
import RealmSwift

// MARK: - User
class Friends: Decodable {
    let response: FriendsResponse
}

// MARK: - Response
class FriendsResponse: Decodable {
    let count: Int
    let items: [User]
}

// MARK: - Item
class User: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var trackCode = ""
    @objc dynamic var photo100 = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
    
    enum TopCodingKeys: String, CodingKey {
        case response
        case items
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let usersValues = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try usersValues.decode(Int.self, forKey: .id)
        self.photo100 = try usersValues.decode(String.self, forKey: .photo100)
        self.lastName = try usersValues.decode(String.self, forKey: .lastName)
        self.firstName = try usersValues.decode(String.self, forKey: .firstName)
    }
    
    override class func primaryKey() -> String? {
            return "id"
        }
    
}
