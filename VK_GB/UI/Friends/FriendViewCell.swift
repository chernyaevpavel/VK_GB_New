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
    
    func configure(name: String, avatar: String?, status: TimeInterval?) {
        self.name.text = name
        self.status.text = ""
//        if let statusInterval = status {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let myString = formatter.string(from: Date(timeIntervalSince1970: statusInterval))
//            self.status.text  = myString
//        }
//        switch status {
//        case .onLine:
//            self.status.textColor = UIColor(named: "colorDarkGreen")
//        case .offLine:
//            self.status.textColor = .red
//        }
        if let avatar = avatar {
            let url = URL(string: avatar)
            apiService.downloadImage(from: url!) { data in
                self.avatar.avatarImage.image = UIImage(data: data)
            }
        } else {
            self.avatar.avatarImage.image = UIImage(named: "no-image")
        }
//        if let tmpImage = avatar {
//            self.avatar.avatarImage.image = tmpImage
//        } else {
//            self.avatar.avatarImage.image = UIImage(named: "no-image")
//        }
    }
}
