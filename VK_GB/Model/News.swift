//
//  Newas.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import Foundation

struct News {
    var id: String
    var header: String
    var news: String
    var images: [Photo]
    var like: Like
    var comments: [Comment]
    var viewing: Int
    var commentCount: Int  {
        comments.count
    }
    var shareCount: Int
    
    init(header: String, news: String, images: [Photo], like: Like, comments: [Comment], viewing: Int, shareCount: Int) {
        self.id = UUID().uuidString
        self.header = header
        self.news = news
        self .images = images
        self.like = like
        self.comments = comments
        self.viewing = viewing
        self.shareCount = shareCount
    }
}
