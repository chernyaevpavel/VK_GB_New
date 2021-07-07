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
