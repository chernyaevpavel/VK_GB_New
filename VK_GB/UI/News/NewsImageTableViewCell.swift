//
//  NewsImageTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 21.07.2021.
//

import UIKit
import SDWebImage

class NewsImageTableViewCell: UITableViewCell {
    static let reuseId = "NewsImageTableViewCell"
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
    
    func configure(news: News) {
        if news.images.count != 0 {
            let photo = news.images[0]
            if let strUrl = photo.photo1280,
               let url = URL(string: strUrl) {
                newsImageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage)
            } else {
                newsImageView.image = UIImage.placeholderImage!
            }
            
        } else {
            newsImageView.image = UIImage.placeholderImage!
        }
    }
}
