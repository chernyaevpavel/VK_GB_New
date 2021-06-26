//
//  FriendSectionHeader.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

struct FriendSectionHeader {
    let letter: String
    var isDetaling: Bool
    var arrFriends: [User]
    
    init(_ letter: String, _ isDetaling: Bool, _ arrFriends: [User]) {
        self.letter = letter
        self.isDetaling = isDetaling
        self.arrFriends = arrFriends
    }
    
    init(_ letter: String, _ arrFriends: [User]) {
        self.init(letter, true, arrFriends)
    }
}
