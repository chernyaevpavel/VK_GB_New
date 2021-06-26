//
//  UserGroupTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
//

import UIKit

class UserGroupTableViewCell: UITableViewCell {
    static let reuseID = "GroupCell"
    @IBOutlet weak private var groupName: UILabel!
    @IBOutlet weak private var groupDescription: UILabel!
    @IBOutlet weak private var groupImage: UIImageView!
    private let apiService = APIService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ group: Group) {
        groupName.text = group.name
        groupDescription.text = ""
        
        
        if let avatar = group.photo200 {
            let url = URL(string: avatar)
            apiService.downloadImage(from: url!) { data in
                self.groupImage.image = UIImage(data: data)
            }
        } else {
            groupImage.image = UIImage(named: "no-image")
        }
//        groupDescription.text = group.description
//        if let named = group.image {
//            groupImage.image = UIImage(named: named)
//        } else {
//            groupImage.image = UIImage(named: "no-image")
//        }
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.layer.masksToBounds = true
    }
}
