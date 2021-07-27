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
import RealmSwift

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
class Group: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo200: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo200 = "photo_200"
        case name
    }
}

