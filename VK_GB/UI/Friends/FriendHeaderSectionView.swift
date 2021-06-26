//
//  FriendHeaderSectionView.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit

class FriendHeaderSectionView: UITableViewHeaderFooterView {
    static let reuseID = "FriendHeaderSectionView"
    
    private let letteLabel: UILabel = {
        let letterLabel = UILabel()
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        return letterLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        letteLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        letteLabel.textColor = .gray
        contentView.addSubview(letteLabel)
        let constraintTop = letteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4)
        let constraintBottom = letteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        let constraintLeading = letteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        let constraintTrailing = letteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        constraintTop.priority = UILayoutPriority(999)
        constraintBottom.priority = UILayoutPriority(999)
        constraintLeading.priority = UILayoutPriority(999)
        constraintTrailing.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([constraintTop, constraintBottom, constraintLeading, constraintTrailing])
    }
    
    func configure(letter: String) {
        letteLabel.text = letter
    }
}
