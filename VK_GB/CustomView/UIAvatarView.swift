//
//  UIAvatarView.swift
//  VK_GB
//
//  Created by Павел Черняев on 01.05.2021.
//

import UIKit

class UIAvatarView: UIView {
    var avatarImage = UIImageView()
    
    var shadowRadius: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let hight = layer.frame.height
        let width = layer.frame.width
        //вьюха, которая отбрасывает тень
        layer.cornerRadius = hight / 2
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 5, height: 2)
        layer.shadowOpacity = 2.0
        //добавим ImageView и скруглим ее
        addSubview(avatarImage)
        avatarImage.frame = CGRect(x: 0, y: 0, width: width, height: hight)
        avatarImage.layer.cornerRadius = hight / 2
        avatarImage.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickAvatar))
        addGestureRecognizer(tap)
    }
    
    @objc func clickAvatar() {
        let val = 0.8
        var animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = val
        animation.duration = 0.5
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.layer.add(animation, forKey: nil)
        animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = val
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 3
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}
