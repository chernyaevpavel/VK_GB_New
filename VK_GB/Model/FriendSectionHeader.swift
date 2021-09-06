//
//  FriendSectionHeader.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

struct FriendSectionHeader {
    let letter: String
    var isDetaling: Bool
    var arrFriends: [UserViewModel]
    
    init(_ letter: String, _ isDetaling: Bool, _ arrFriends: [UserViewModel]) {
        self.letter = letter
        self.isDetaling = isDetaling
        self.arrFriends = arrFriends
    }
    
    init(_ letter: String, _ arrFriends: [UserViewModel]) {
        self.init(letter, true, arrFriends)
    }
}
