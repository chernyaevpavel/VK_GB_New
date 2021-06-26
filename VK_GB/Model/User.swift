// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let frien = try? newJSONDecoder().decode(Frien.self, from: jsonData)

import Foundation

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
struct User: Codable {
    let faculty: Int?
    let mobilePhone, bdate, status: String?
    let country: City?
    let relation: Int?
    let nickname: String?
    let sex: Int
    let photo200_Orig: String?
    let canPost: Int
    let photo50: String
    let lastName: String
    let city: City?
    let homePhone, universityName: String?
    let lastSeen: LastSeen?
    let facultyName: String?
    let domain: String
    let id: Int
    let graduation: Int?
    let educationForm: EducationForm?
    let canWritePrivateMessage: Int
    let hasMobile, university: Int?
    let trackCode: String
    let educationStatus: String?
    let canSeeAllPosts: Int?
    let firstName: String
    let universities: [University]?
    let online: Int
    let photo100: String
    let deactivated: String?
    let relationPartner: RelationPartner?
    let onlineApp, onlineMobile: Int?

    enum CodingKeys: String, CodingKey {
        case faculty
        case mobilePhone = "mobile_phone"
        case bdate, status, country, relation, nickname, sex
        case photo200_Orig = "photo_200_orig"
        case canPost = "can_post"
        case photo50 = "photo_50"
        case lastName = "last_name"
        case city
        case homePhone = "home_phone"
        case universityName = "university_name"
        case lastSeen = "last_seen"
        case facultyName = "faculty_name"
        case domain, id, graduation
        case educationForm = "education_form"
        case canWritePrivateMessage = "can_write_private_message"
        case hasMobile = "has_mobile"
        case university
        case trackCode = "track_code"
        case educationStatus = "education_status"
        case canSeeAllPosts = "can_see_all_posts"
        case firstName = "first_name"
        case universities, online
        case photo100 = "photo_100"
        case deactivated
        case relationPartner = "relation_partner"
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
    }
}

enum EducationForm: String, Codable {
    case заочноеОтделение = "Заочное отделение"
    case очноеОтделение = "Очное отделение"
}
// MARK: - LastSeen
struct LastSeen: Codable {
    let platform, time: Int
}

// MARK: - RelationPartner
struct RelationPartner: Codable {
    let id: Int
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

// MARK: - University
struct University: Codable {
    let facultyName: String?
    let city, country: Int
    let chair: Int?
    let chairName: String?
    let id: Int
    let educationForm: EducationForm?
    let educationStatus: String?
    let name: String
    let faculty, graduation: Int?

    enum CodingKeys: String, CodingKey {
        case facultyName = "faculty_name"
        case city, country, chair
        case chairName = "chair_name"
        case id
        case educationForm = "education_form"
        case educationStatus = "education_status"
        case name, faculty, graduation
    }
}

