//
//  FriendPhotoCollectionViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell, ChangeStatusLikeProtocol {
    static let reuseID = "FriendPhotoCollectionViewCell"
    @IBOutlet weak private var photo: UIImageView!
    @IBOutlet weak private var likeControl: ILikeControl!
    private var likePhoto: Photo?
    weak var delegate: ChangeStatusLikeObjectProtocol?
    private let apiService = APIService()
    
    override func prepareForReuse() {
        photo.image = nil
        likeControl.countLike = 0
        likeControl.isLike = false
    }
    
    func configure(photo: Photo) {
        self.likePhoto = photo
        likeControl.countLike = photo.likes.count
        likeControl.isLike = false
        likeControl.delegate = self
        likeControl.drawControl()
        
        if let urlPhoto = photo.photo807 {
            let url = URL(string: urlPhoto)
            apiService.downloadImage(from: url!) { data in
                self.photo.image = UIImage(data: data)
            }
        } else {
            self.photo.image = UIImage(named: "no-image")
        }
        
        
//        let image = UIImage(named: likePhoto.photo.name)
//        if let tmpImage = image {
//            photo.image = tmpImage
//        } else {
//            photo.image = UIImage(named: "no-image")
//        }
    }
    
    func changeStatusLike(status: Bool) {
        delegate?.changeStatus(status: status, obj: likePhoto)
    }
}
