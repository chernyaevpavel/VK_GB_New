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
    let instets: CGFloat = 10.0
    let instestTop: CGFloat = 5.0
    
    override func prepareForReuse() {
        authorLabel.text = ""
        dateTimeLabel.text = ""
    }
    
    func configure(news: News, namesAuthor: [String: String], dateFormatter: DateFormatter, dateTextCache: inout [Date: String]) {
        let id = news.author
        self.authorLabel.text = namesAuthor[id]
        self.dateTimeLabel.text = getDateText(dateTime: news.dateTime, dateFormatter: dateFormatter, dateTextCache: &dateTextCache)
        setupView()
    }
    
    private func getDateText(dateTime: Date, dateFormatter: DateFormatter, dateTextCache: inout [Date: String]) -> String {
        if let dateText = dateTextCache[dateTime] { return dateText }
        let dateText = dateFormatter.string(from: dateTime)
        dateTextCache[dateTime] = dateText
        return dateText
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - instets * 2
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        // получаем ширину блока, переводим её в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим её в Double
        let height = Double(rect.size.height)
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        let sizeAuthor = getLabelSize(text: authorLabel.text ?? "", font: authorLabel.font)
        let pointAuthor = CGPoint(x: 0, y: instestTop)
        let sizeTime = getLabelSize(text: dateTimeLabel.text ?? "", font: dateTimeLabel.font)
        let pointTime = CGPoint(x: 0, y: sizeAuthor.height + instestTop *  2)
        authorLabel.frame = CGRect(origin: pointAuthor, size: sizeAuthor)
        dateTimeLabel.frame = CGRect(origin: pointTime, size: sizeTime)
    }
    
    func getHightRow(news: News, namesAuthor: [String: String], dateFormatter: DateFormatter, dateTextCache: inout [Date: String], hightsCache: inout [IndexPath: CGFloat], indexPath: IndexPath) -> CGFloat {
        if let hight = hightsCache[indexPath] { return hight }
        let id = news.author
        guard let nameAuthor = namesAuthor[id] else { return 0 }
        let sizeAuthor = getLabelSize(text: nameAuthor, font: authorLabel.font)
        let textTime = getDateText(dateTime: news.dateTime , dateFormatter: dateFormatter, dateTextCache: &dateTextCache)
        let sizeTime = getLabelSize(text: textTime, font: dateTimeLabel.font)
        let hight = sizeAuthor.height + sizeTime.height + instestTop * 3
        hightsCache[indexPath] = hight
        return hight
    }
}
