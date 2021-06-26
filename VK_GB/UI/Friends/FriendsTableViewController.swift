//
//  FrindsTableViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 29.04.2021.
//

import UIKit

protocol SelectLetterProtocol: AnyObject {
    func selectLetter(_ letter: String)
}

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectLetterProtocol {
//    var arrFriens: [Friend] = []
    
    private var arrFirstLetter =  [String]()
    private var friendsDictionary = [String: FriendSectionHeader]()
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var letterControl: SelectLetterControl!
    private let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendHeaderSectionView.self, forHeaderFooterViewReuseIdentifier: FriendHeaderSectionView.reuseID)
        let fillFakeData = FillFakeData()
        var arrFriends = [User]()
        apiService.getFriends { users in
            arrFriends = users
            self.arrFirstLetter = fillFakeData.arrFirstChar(arrFriends: arrFriends)
            self.letterControl.arrLetters = self.arrFirstLetter
            self.letterControl.delegate = self
            for letter in self.arrFirstLetter {
                let key = letter
                let value = FriendSectionHeader(letter, self.filterFriendByLetter(arrFriends, letter))
                self.friendsDictionary[key] = value
            }
            self.tableView.reloadData()
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
        let avatar = friend.photo200_Orig

        let name = "\(friend.firstName) \(friend.lastName)"
//        var lastSeen: TimeInterval?
//        if let lS = friend.lastSeen?.time {
//            lastSeen = TimeInterval(lS)
//        }
        cell.configure(name: name , avatar: avatar, status: nil)
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
    
    private func filterFriendByLetter(_ arr: [User], _ letter: String) -> [User] {
        return arr.filter({ String($0.firstName.first ?? "*") == letter })

    }
}
