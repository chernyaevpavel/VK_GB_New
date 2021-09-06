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
        likeControl.countLike = photo.likes?.count ?? 0
        likeControl.isLike = false
        likeControl.delegate = self
        likeControl.drawControl()
        
        guard let strURL = photo.photo807 else { return }
        guard let url = URL(string: strURL) else { return }
        self.photo.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage)
    }
    
    func changeStatusLike(status: Bool) {
        delegate?.changeStatus(status: status, obj: likePhoto)
    }
}
