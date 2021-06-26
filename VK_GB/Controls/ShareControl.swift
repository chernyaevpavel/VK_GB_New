//
//  ShareControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 10.05.2021.
//

import UIKit

class ShareControl: UIControl {
    private let shareButton = UIButton()
    private let shareCountLabel = UILabel()
    private let imageShare = UIImage(systemName: "arrowshape.turn.up.right")
    
    var shareCount: Int = 0 {
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
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(imageShare, for: .normal)
        shareButton.tintColor = .link
        shareButton.addTarget(self, action: #selector(clicShareButton), for: .touchUpInside)
        addSubview(shareButton)
        shareCountLabel.text = String(shareCount)
        shareCountLabel.frame = CGRect(x: 25, y: 0, width: 50, height: 20)
        addSubview(shareCountLabel)
    }
    
    @objc func clicShareButton() {
        shareCount += 1
    }
}
