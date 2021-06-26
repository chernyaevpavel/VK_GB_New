//
//  NewsViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit

class NewsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChangeStatusLikeObjectProtocol {
    
    private let arrNews: [News] = {
        let arrNews = FillFakeData.fillNews()
        return arrNews
    }()
    
    @IBOutlet weak private var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID) as! NewsTableViewCell
        let news = arrNews[indexPath.row]
        cell.configure(news: news)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }
    
    func changeStatus<T>(status: Bool, obj: T) {
        guard let news = obj as? News else { return }
        guard let elem = arrNews.first(where: { $0.id == news.id }) else { return }
        elem.like.isLike = status
    }
}
