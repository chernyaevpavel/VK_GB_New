// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let frien = try? newJSONDecoder().decode(Frien.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Frien
struct Friends: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [User]
}

// MARK: - Item
class User: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var photo200_Orig: String?
    @objc dynamic var online: Int

    enum CodingKeys: String, CodingKey {
        case id, online
        case photo200_Orig = "photo_200_orig"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}



