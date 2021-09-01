//
//  NewsAuthorTableViewCell.swift
//  VK_GB
//
//  Created by Павел Черняев on 21.07.2021.
//

import UIKit

class NewsAuthorTableViewCell: UITableViewCell {
    static let reuseId = "NewsAuthorTableViewCell"
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        authorLabel.text = ""
        dateTimeLabel.text = ""
    }
    
    func configure(news: News, namesAuthor: [String: String]) {
        let id = news.author
        self.authorLabel.text = namesAuthor[id]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateTimeLabel.text = dateFormatter.string(from: news.dateTime)
    }
}
