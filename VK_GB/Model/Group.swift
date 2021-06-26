//
//  Group.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
//

//struct Group {
//    var name: String
//    let subjectMater: SubjectMatter
//    private(set) var countUser: Int
//    var image: String?
//    var description: String {
//        subjectMater.rawValue + ", " + String(countUser) + " участников"
//    }
//
//    mutating func addUser(count: Int = 1) {
//        countUser += count
//    }
//
//    mutating func removeUser(count: Int = 1) {
//        if count <= countUser {
//            countUser -= count
//        }
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupResponse = try? newJSONDecoder().decode(GroupResponse.self, from: jsonData)

import Foundation

// MARK: - GroupResponse
struct GroupResponse: Codable {
    let response: ResponseGroup
}

// MARK: - Response
struct ResponseGroup: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let isMember, id: Int
    let photo100: String?
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String?
    let type, screenName, name: String
    let isClosed: Int
    let city: City?

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
        case city
    }
}

