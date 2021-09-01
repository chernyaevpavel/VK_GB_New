//
//  NewsTextTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 21.07.2021.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {
    static let reuseID = "NewsTextTableViewCell"
    
    @IBOutlet weak var textNewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        textNewsLabel.text = ""
    }
    
    func configure(news: News) {
        textNewsLabel.text = news.textNews
    }
    
}
