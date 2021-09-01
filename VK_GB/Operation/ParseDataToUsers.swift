//
//  ParseDataToUsers.swift
//  VK_GB
//
//  Created by Павел Черняев on 03.08.2021.
//

import Foundation

class ParseDataToUsers: Operation {
    var users: [User] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data)
        guard let users = friendsResponse?.response.items else { return }
        self.users = users
    }
}
