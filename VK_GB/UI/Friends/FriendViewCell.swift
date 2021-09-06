//
//  FrindViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit
import SDWebImage

class FriendViewCell: UITableViewCell {
    static let reuseID = "FrindCell"
    @IBOutlet private weak var avatar: UIAvatarView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var status: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(user: UserViewModel){
        self.name.text = user.fullName
        self.status.text = user.status
        self.status.textColor = user.statusColor
        self.avatar.avatarImage.sd_setImage(with: user.url, placeholderImage: UIImage.placeholderImage)
    }
}
