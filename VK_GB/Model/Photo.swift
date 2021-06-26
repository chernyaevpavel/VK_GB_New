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
struct Photo: Codable {
    let id: Int
    let photo2560, photo807: String?
    let realOffset: Int
    let photo1280: String?
    let likes: Likes
    let photo604: String
    let reposts: Reposts
    let photo130: String?
    let date, ownerID: Int
    let text: String
    let hasTags: Bool
    let albumID: Int
    let photo75: String
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case realOffset = "real_offset"
        case photo1280 = "photo_1280"
        case likes
        case photo604 = "photo_604"
        case reposts
        case photo130 = "photo_130"
        case date
        case ownerID = "owner_id"
        case text
        case hasTags = "has_tags"
        case albumID = "album_id"
        case photo75 = "photo_75"
        case postID = "post_id"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}
