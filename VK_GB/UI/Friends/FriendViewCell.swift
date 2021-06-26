//
//  FrindViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit

class FriendViewCell: UITableViewCell {
    static let reuseID = "FrindCell"
    @IBOutlet private weak var avatar: UIAvatarView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var status: UILabel!
    private let apiService = APIService()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(friend: User){
        self.name.text = "\(friend.firstName) \(friend.lastName)"
        var status: Status = .offLine
            switch friend.online {
            case 1:
                status = .onLine
            default:
                status = .offLine
            }
        self.status.text = status.rawValue
        switch status {
        case .onLine:
            self.status.textColor = UIColor(named: "colorDarkGreen")
        case .offLine:
            self.status.textColor = .red
        }
        if let avatar = friend.photo200_Orig {
            let url = URL(string: avatar)
            apiService.downloadImage(from: url!) { data in
                self.avatar.avatarImage.image = UIImage(data: data)
            }
        } else {
            self.avatar.avatarImage.image = UIImage(named: "no-image")
        }
    }
}
