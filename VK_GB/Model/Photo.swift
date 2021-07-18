//
//  Photo.swift
//  VK_GB
//
//  Created by Павел Черняев on 03.05.2021.
//

//struct Photo {
//    var name: String
//
//    init(_ name: String) {
//        self.name = name
//    }
//}



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photoResponse = try? newJSONDecoder().decode(PhotoResponse.self, from: jsonData)

import Foundation
import RealmSwift
import DynamicJSON

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [Photo]
    let more: Int
}

// MARK: - Item
class Photo: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var ownerId: Int
    @objc dynamic var photo2560, photo807: String?
    @objc dynamic var photo1280: String?
    @objc dynamic var likes: Likes?
    @objc dynamic var photo604: String?
    @objc dynamic var photo130: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case likes
        case photo604 = "photo_604"
        case photo130 = "photo_130"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    
    convenience init(data: JSON) {
        self.init()
        self.id = data.photo.id.int ?? 0
        self.ownerId = data.photo.owner_id.int ?? 0
        self.likes = nil
        guard let sizes = data.photo.sizes.array else { return }
        for size in sizes {
            guard let sizeType = size.type.string,
                  let url = size.url.string
            else {
                continue
            }
            switch sizeType {
            case "w":
                self.photo2560 = url
            case "y":
                self.photo807 = url
            case "z":
                self.photo1280 = url
            case "x":
                self.photo604 = url
            case "m":
                self.photo130 = url
            default:
                continue
            }
            
        }
    }
}

// MARK: - Likes
class Likes: Object, Codable {
    @objc dynamic var userLikes: Int
    @objc dynamic var count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}
