//
//  Newas.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import Foundation
import DynamicJSON

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
    
    init(data: JSON) {
        self.id = data.post_id.string ?? ""
        self.header = ""
        self.news = data.text.string ?? ""
        self.like = Like(data.likes.count.int ?? 0)
        self.comments = Array(repeating: Comment(author: nil), count: data.comments.count.int ?? 0)
        self.viewing = data.views.count.int ?? 0
        self.shareCount = data.reposts.count.int ?? 0
        self.images = []
        
        guard let attachments = data.attachments.array else { return }
        for attachment in attachments{
            if attachment.type.string == "photo" {
                let photo = Photo(data: attachment)
                images.append(photo)
            }
        }
    }
}
