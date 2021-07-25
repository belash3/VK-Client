//
//  UserPhoto.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.06.2021.
//


import Foundation
import RealmSwift

// MARK: - Photo

class UserPhotos: Decodable {
    let response: UserPhotosResponse
}

// MARK: - Response
class UserPhotosResponse: Decodable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
class Photo: Object, Decodable {
    @objc dynamic var albumID = 0
    @objc dynamic var id = 0
    @objc dynamic var date = 0
    @objc dynamic var text = ""
    @objc dynamic var hasTags = false
    @objc dynamic var ownerID = 0
    let sizeList  = List<Size>()
    
    enum CodingKeys: String, CodingKey {
        case id, date, text, sizes
        case albumID = "album_id"
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let photoValues = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try photoValues.decode(Int.self, forKey: .id)
        self.date = try photoValues.decode(Int.self, forKey: .date)
        self.text = try photoValues.decode(String.self, forKey: .text)
        self.albumID = try photoValues.decode(Int.self, forKey: .albumID)
        self.hasTags = try photoValues.decode(Bool.self, forKey: .hasTags)
        self.ownerID = try photoValues.decode(Int.self, forKey: .ownerID)
        let photoArray = try photoValues.decodeIfPresent([Size].self, forKey: .sizes) ?? [Size()]
        sizeList.append(objectsIn: photoArray)
    }
    
    override class func primaryKey() -> String? {
            return "id"
        }
}

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var width = 0
    @objc dynamic var height = 0
    @objc dynamic var url = ""
    @objc dynamic var type = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case width
        case height
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.height = try container.decode(Int.self, forKey: .height)
        self.width = try container.decode(Int.self, forKey: .width)
        self.type = try container.decode(String.self, forKey: .type)
    }
    
}

