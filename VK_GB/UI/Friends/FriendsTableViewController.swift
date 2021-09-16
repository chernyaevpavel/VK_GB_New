//
//  FrindsTableViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit
import RealmSwift

protocol SelectLetterProtocol: AnyObject {
    func selectLetter(_ letter: String)
}

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectLetterProtocol {
    private var arrFirstLetter =  [String]()
    private var friendsDictionary = [String: FriendSectionHeader]()
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var letterControl: SelectLetterControl!
    lazy private var apiService = APIService()
    lazy private var apiServiceProxy = APIServiceProxy(apiService)
    private let realmService = RealmService()
    private let countLoadFriends = "COUNT_LOAD_FRIENDS"
    private var realmNotificationToken: NotificationToken?
    private let userViewModelFactory = UserViewModelFactory()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendHeaderSectionView.self, forHeaderFooterViewReuseIdentifier: FriendHeaderSectionView.reuseID)
        let fillFakeData = FillFakeData()
        
        loadUsers {
            let arrFriends = self.realmService.getUsers()
            self.realmNotificationToken = arrFriends.observe({ (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    self.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    print(error)
                }
            })
            self.arrFirstLetter = fillFakeData.arrFirstChar(arrFriends: Array(arrFriends))
            self.letterControl.arrLetters = self.arrFirstLetter
            self.letterControl.delegate = self
            let arrUserViewModel = self.userViewModelFactory.constructViewModels(from: Array(arrFriends))
            for letter in self.arrFirstLetter {
                let key = letter
                let value = FriendSectionHeader(letter, self.filterFriendByLetter(arrUserViewModel, letter))
                self.friendsDictionary[key] = value
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = arrFirstLetter[section]
        return friendsDictionary[letter]?.arrFriends.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendViewCell.reuseID , for: indexPath) as! FriendViewCell
        let section = indexPath.section
        let index = indexPath.row
        let letter = arrFirstLetter[section]
        guard let friend = friendsDictionary[letter]?.arrFriends[index] else { return cell}
//        cell.configure(friend: friend)
        cell.configure(user: friend)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowFriendPhotos" else { return }
        guard let friendPhotosCollectionViewController: FriendPhotosCollectionViewController = segue.destination as? FriendPhotosCollectionViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let letter = arrFirstLetter[indexPath.section]
        guard let friend = friendsDictionary[letter]?.arrFriends[indexPath.row] else {
            return
        }
        friendPhotosCollectionViewController.friendID = friend.id
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendHeaderSectionView.reuseID) as! FriendHeaderSectionView
        let letter = arrFirstLetter[section]
        header.configure(letter: letter)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func selectLetter(_ letter: String) {
        guard let section = arrFirstLetter.firstIndex(of: letter) else { return }
        let indexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    private func filterFriendByLetter(_ arr: [UserViewModel], _ letter: String) -> [UserViewModel] {
        return arr.filter({ String($0.fullName.first ?? "*") == letter })
        
    }
    
    private func loadUsers(comletion: @escaping()->()) {
        //грузим каждую 3-ю загрузку или когда база пустая
        var cnt = UserDefaults.standard.integer(forKey: countLoadFriends)
        cnt = cnt + 1 == 3 ? 0 : cnt + 1
        UserDefaults.standard.set(cnt, forKey: countLoadFriends)
        cnt = 0 //заглушка для тестов
        if realmService.getUsers().isEmpty || cnt == 0 {
            apiServiceProxy.getFriends { users in
                OperationQueue.main.addOperation {
                    self.realmService.addUsers(users: users)
                    comletion()
                }
            }
        } else {
            comletion()
        }
        
    }
}
