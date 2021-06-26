//
//  LikeControlModel.swift
//  VK_GB
//
//  Created by Павел Черняев on 04.05.2021.
//

class Like {
    var countLike: Int
    var isLike: Bool
    
    init(_ countLike: Int, _ isLike: Bool) {
        self.countLike = countLike
        self.isLike = isLike
    }
    
    init(_ countLike: Int) {
        self.countLike = countLike
        self.isLike = false
    }
}
