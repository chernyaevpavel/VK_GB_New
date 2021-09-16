//
//  NewsViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 09.05.2021.
//

import UIKit

class NewsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChangeStatusLikeObjectProtocol {
    
    private var arrNews: [News] = []
    private var namesAuthor = [String: String]()
    @IBOutlet weak private var tableView: UITableView!
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        return df
    }()
    var dateTextCache = [Date: String]()
    var hightsCache = [IndexPath: CGFloat]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrNews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNews[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = arrNews[indexPath.section]
        let row = indexPath.row
        switch news.rows[row] {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorTableViewCell.reuseId) as! NewsAuthorTableViewCell
            cell.configure(news: news, namesAuthor: namesAuthor, dateFormatter: self.dateFormatter, dateTextCache: &dateTextCache)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextTableViewCell.reuseID) as! NewsTextTableViewCell
            cell.configure(news: news)
            return cell
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageTableViewCell.reuseId) as! NewsImageTableViewCell
            cell.configure(news: news)
            return cell
        case .likeCommentControls:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID) as! NewsTableViewCell
            cell.configure(news: news)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let auD = UITableView.automaticDimension
        let news = arrNews[indexPath.section]
        let row = indexPath.row
        switch news.rows[row] {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorTableViewCell.reuseId) as! NewsAuthorTableViewCell
            return cell.getHightRow(news: news, namesAuthor: namesAuthor, dateFormatter: dateFormatter, dateTextCache: &dateTextCache, hightsCache: &hightsCache, indexPath: indexPath)
        default:
            return auD
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        hightsCache = [:]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.register(UINib(nibName: "NewsAuthorTableViewCell", bundle: nil), forCellReuseIdentifier: NewsAuthorTableViewCell.reuseId)
        tableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTextTableViewCell.reuseID)
        tableView.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: NewsImageTableViewCell.reuseId)
    }
    
    func changeStatus<T>(status: Bool, obj: T) {
        guard let news = obj as? News else { return }
        guard let elem = arrNews.first(where: { $0.id == news.id }) else { return }
        elem.like.isLike = status
    }
    
    private func loadNews() {
        let apiService = APIService()
        let apiServiceProxy = APIServiceProxy(apiService)
        apiServiceProxy.getNews { result in
            switch result {
            case .failure(let error):
                self.alertError(text: error.description)
            case .success(let news):
                DispatchQueue.global().async {
                    self.arrNews = news
                    self.getNamesGroup(arrNews: news) { names in
                        for key in names.keys {
                            self.namesAuthor[key] = names[key]
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    self.getNamesUsers(arrNews: news) { names in
                        for key in names.keys {
                            self.namesAuthor[key] = names[key]
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func getNamesUsers(arrNews: [News], comletion: @escaping([String: String]) -> ()) {
        let apiService = APIService()
        let apiServiceProxy = APIServiceProxy(apiService)
        var idUsers = ""
        for new in arrNews {
            let authorID = new.author
            if !authorID.hasPrefix("-") {
                if !idUsers.contains(authorID) {
                    idUsers = idUsers + authorID + ","
                }
            }
        }
        
        if !idUsers.isEmpty {
            apiServiceProxy.getUserName(userID: idUsers) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let namesDictionary):
                    comletion(namesDictionary)
                }
            }
        } else{
            comletion([:])
        }
    }
    
    func getNamesGroup(arrNews: [News], comletion: @escaping([String: String]) -> ()) {
        let apiService = APIService()
        let apiServiceProxy = APIServiceProxy(apiService)
        var idGroups = ""
        var idUsers = ""
        for new in arrNews {
            var authorID = new.author
            if authorID.hasPrefix("-") {
                authorID.remove(at: authorID.startIndex)
                if !idGroups.contains(authorID) {
                    idGroups = idGroups + authorID + ","
                }
            } else {
                if !idUsers.contains(authorID) {
                    idUsers = idUsers + authorID + ","
                }
            }
        }
        
        if !idGroups.isEmpty {
            apiServiceProxy.getGroupName(groupID: idGroups) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let namesDictionary):
                    comletion(namesDictionary)
                }
            }
        } else {
            comletion([:])
        }
    }
    
    func alertError(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
