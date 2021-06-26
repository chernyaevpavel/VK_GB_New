//
//  NewsTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell, ChangeStatusLikeProtocol {
    
    static let reuseID = "NewsTableViewCell"
    @IBOutlet weak private var headerLabel: UILabel!
    @IBOutlet weak private var descriptionNewsLabel: UILabel!
    @IBOutlet weak private var newsImageView: UIImageView!
    @IBOutlet weak private var newsLikeControl: ILikeControl!
    @IBOutlet weak private var commentControl: CommentControl!
    @IBOutlet weak private var shareControl: ShareControl!
    @IBOutlet weak private var eyeControl: EyeControl!
    private var news: News?
    var delegate: ChangeStatusLikeObjectProtocol?
    private let countCharPreviewNews = 200
    
    override func prepareForReuse() {
        headerLabel.text = ""
        newsLikeControl.countLike = 0
        newsLikeControl.isLike = false
        newsImageView.image = nil
    }
    
    func configure(news: News) {
        self.news = news
        headerLabel.text = news.header
        descriptionNewsLabel.text = news.news
        
        if news.images.count != 0 {
            let photo = news.images[0]
//            let nameImage = photo.name
//            if let image = UIImage(named: nameImage) {
//                newsImageView.image = image
//            } else {
//                newsImageView.image = UIImage(named: "no-image")!
//            }
        } else {
            newsImageView.image = UIImage(named: "no-image")!
        }
        
        newsLikeControl.countLike = news.like.countLike
        newsLikeControl.isLike = news.like.isLike
        newsLikeControl.delegate = self
        commentControl.commentsCount = news.commentCount
        shareControl.shareCount = news.shareCount
        eyeControl.countViewing = news.viewing
    }
    
    func changeStatusLike(status: Bool) {
        guard let tmpNews = news else { return  }
        delegate?.changeStatus(status: status, obj: tmpNews)
    }
}
