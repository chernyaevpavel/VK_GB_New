//
//  LikePhoto.swift
//  VK_GB
//
//  Created by Павел Черняев on 03.05.2021.
//

class LikePhoto {
    var photo: Photo
    var like: Like
    
    init(_ photo: Photo, _ like: Like) {
        self.photo = photo
        self.like = like
    }
    
}
