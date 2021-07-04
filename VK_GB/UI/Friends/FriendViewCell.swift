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
    
    func configure(friend: User){
        self.name.text = "\(friend.firstName) \(friend.lastName)"
        self.status.text = friend.status.rawValue
        switch friend.status {
        case .onLine:
            self.status.textColor = UIColor(named: "colorDarkGreen")
        case .offLine:
            self.status.textColor = .red
        }
        
        self.avatar.avatarImage.sd_setImage(with: URL(string: friend.photo200_Orig!), placeholderImage: UIImage(named: "no-image"))
    }
}
