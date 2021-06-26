//
//  CommentControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 10.05.2021.
//

import UIKit

class CommentControl: UIControl {
    private let commentButton = UIButton()
    private let commentsCountLabel = UILabel()
    private let imageComment = UIImage(systemName: "bubble.left")
    
    var commentsCount: Int = 0 {
        didSet {
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .none
        commentButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        commentButton.setImage(imageComment, for: .normal)
        commentButton.tintColor = .link
        commentButton.addTarget(self, action: #selector(clicCommentButton), for: .touchUpInside)
        addSubview(commentButton)
        commentsCountLabel.text = String(commentsCount)
        commentsCountLabel.frame = CGRect(x: 25, y: 0, width: 50, height: 20)
        addSubview(commentsCountLabel)
    }
    
    @objc func clicCommentButton() {
        commentsCount += 1
    }
}
