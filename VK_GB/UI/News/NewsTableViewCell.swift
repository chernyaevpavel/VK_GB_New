//
//  NewsTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell, ChangeStatusLikeProtocol {
    static let reuseID = "NewsTableViewCell"
    @IBOutlet weak private var newsLikeControl: ILikeControl!
    @IBOutlet weak private var commentControl: CommentControl!
    @IBOutlet weak private var shareControl: ShareControl!
    @IBOutlet weak private var eyeControl: EyeControl!
    private var news: News?
    var delegate: ChangeStatusLikeObjectProtocol?
    private let countCharPreviewNews = 200
    
    override func prepareForReuse() {
        newsLikeControl.countLike = 0
        newsLikeControl.isLike = false
        commentControl.commentsCount = 0
        eyeControl.countViewing = 0
    }
    
    func configure(news: News) {
        self.news = news
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
