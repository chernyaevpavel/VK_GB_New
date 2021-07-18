//
//  NewsViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit

class NewsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChangeStatusLikeObjectProtocol {
    
    private var arrNews: [News] = []
    
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
        loadNews()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }
    
    func changeStatus<T>(status: Bool, obj: T) {
        guard let news = obj as? News else { return }
        guard let elem = arrNews.first(where: { $0.id == news.id }) else { return }
        elem.like.isLike = status
    }
    
    private func loadNews() {
        let api = APIService()
        api.getNews { result in
            switch result {
            case .failure(let error):
                self.alertError(text: error.description)
            case .success(let news):
                print(news)
                self.arrNews = news
                self.tableView.reloadData()
            }
        }
    }
    
    func alertError(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
