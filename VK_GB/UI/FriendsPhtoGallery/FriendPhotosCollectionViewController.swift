//
//  FriendPhotosCollectionViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit

class FriendPhotosCollectionViewController: UICollectionViewController, ChangeStatusLikeObjectProtocol  {
    
    var friendID: Int = 0
//    var friendPhotos: [LikePhoto] = []
    var friendPhotos: [Photo] = []
    private let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getPhotos(ownerID: String(friendID)) { photos in
            self.friendPhotos = photos
            self.collectionView.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCollectionViewCell.reuseID, for: indexPath) as! FriendPhotoCollectionViewCell
        let index = indexPath.row
        let photo = friendPhotos[index]
        cell.configure(photo: photo)
        cell.delegate = self
        return cell
    }
    
    func changeStatus<T>(status: Bool, obj: T) {
//        guard let likePhoto = obj as? LikePhoto else { return }
//        let item = friendPhotos.first(where: {$0.photo.name == likePhoto.photo.name})
//        item?.like.isLike = status
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "ShowFullPhoto" else { return }
//        guard let destination = segue.destination as? FriendPhotosFullViewController else { return }
//        destination.friendPhotos = friendPhotos
        
        
        guard segue.identifier == "ShowFullPhoto" else { return }
        guard  let destination = segue.destination as? FriendPhotoAnimationViewController else { return }
        destination.friendPhotos = friendPhotos
        let index = collectionView.indexPathsForSelectedItems![0].row
        destination.currentIndexPhoto = index
        
    }
}
