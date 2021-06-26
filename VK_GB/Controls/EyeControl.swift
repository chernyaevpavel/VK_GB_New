//
//  EyeControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 10.05.2021.
//

import UIKit

class EyeControl: UIControl {
    private let eyeImageView = UIImageView()
    private var countViewingLabel = UILabel()
    var countViewing = 0 {
        didSet {
            setupView()
        }
    }
    static let eyeImage = UIImage(systemName: "eye")
    
    func setupView() {
        backgroundColor = .none
        eyeImageView.image = EyeControl.eyeImage
        eyeImageView.tintColor = .systemGray2
        eyeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(eyeImageView)
        countViewingLabel.text = String(countViewing)
        countViewingLabel.textColor = .systemGray2
        countViewingLabel.textAlignment = .left
        countViewingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countViewingLabel)
        
        NSLayoutConstraint.activate([
            eyeImageView.topAnchor.constraint(equalTo: topAnchor),
            eyeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            eyeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countViewingLabel.topAnchor.constraint(equalTo: topAnchor),
            countViewingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countViewingLabel.leadingAnchor.constraint(equalTo: eyeImageView.trailingAnchor, constant: 4),
            countViewingLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
