//
//  Newas.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import Foundation
import DynamicJSON

enum TypeRowsNews {
    case author
    case image
    case text
    case likeCommentControls
}

struct News {
    var id: String
    var textNews: String?
    var images: [Photo]
    var like: Like
    var comments: [Comment]
    var viewing: Int
    var commentCount: Int  {
        comments.count
    }
    var shareCount: Int
    var author: String
    var dateTime: Date
    var rows: [TypeRowsNews] {
        var arr = [TypeRowsNews]()
        arr.append(.author)
        if let _ = textNews { arr.append(.text) }
        if images.count > 0  {
            if let _ = images.first?.photo1280 { arr.append(.image) }
        }
        arr.append(.likeCommentControls)
        return arr
    }
    
    init(textNews: String, images: [Photo], like: Like, comments: [Comment], viewing: Int, shareCount: Int, author: String, dateTime: Date) {
        self.id = UUID().uuidString
        self.textNews = textNews
        self .images = images
        self.like = like
        self.comments = comments
        self.viewing = viewing
        self.shareCount = shareCount
        self.author = author
        self.dateTime = dateTime
    }
    
    init(data: JSON) {
        self.id = data.post_id.string ?? ""
        self.textNews = data.text.string ?? ""
        self.like = Like(data.likes.count.int ?? 0)
        self.comments = Array(repeating: Comment(author: nil), count: data.comments.count.int ?? 0)
        self.viewing = data.views.count.int ?? 0
        self.shareCount = data.reposts.count.int ?? 0
        self.images = []
        self.author = data.source_id.string ?? ""
        self.dateTime = Date(timeIntervalSince1970: TimeInterval(data.date.int ?? 0))
        
        guard let attachments = data.attachments.array else { return }
        for attachment in attachments{
            if attachment.type.string == "photo" {
                let photo = Photo(data: attachment)
                images.append(photo)
            }
        }
    }
}
