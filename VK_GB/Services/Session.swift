//
//  Session.swift
//  VK_GB
//
//  Created by Павел Черняев on 17.06.2021.
//

final class Session {
    
    static let shared = Session()

    private init() {}
    
    var token: String = ""
    var userId: String = ""
    
}
