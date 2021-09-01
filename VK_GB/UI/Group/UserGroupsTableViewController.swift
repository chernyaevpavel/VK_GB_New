//
//  UserGroupsTableViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
//

import UIKit
import RealmSwift

class UserGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    private var userGroups = [Group]()
    private var foundUserGroup = [Group]()
    private var isSearch = false
    @IBOutlet weak var searchBar: UISearchBar!
    private let apiService = APIService()
    private let realmService = RealmService()
    private let countLoadGroups = "COUNT_LOAD_GROUPS"
    private var realmNotificationToken: NotificationToken?
    
    func foundGrupsByText(_ text: String) -> [Group] {
        return userGroups.filter({$0.name.lowercased().contains(text.lowercased()) })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
        } else {
            foundUserGroup = foundGrupsByText(searchText)
            isSearch = true
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadGroups {
            let userGroupsRealm = self.realmService.getGroups()
            self.userGroups = Array(userGroupsRealm)
            self.realmNotificationToken = userGroupsRealm.observe({ (changes: RealmCollectionChange) in
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
        }   
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? foundUserGroup.count : userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupTableViewCell.reuseID, for: indexPath) as! UserGroupTableViewCell
        let index = indexPath.row
        let group = isSearch ? foundUserGroup[index] : userGroups[index]
        cell.configure(group)
        return cell
    }
     
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            if isSearch {
                foundUserGroup.remove(at: index)
            } else {
                userGroups.remove(at: index)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard segue.identifier == "AddGroup",
              let sourceController = segue.source as? GlobalGroupsTableViewController,
              let indexPath = sourceController.tableView.indexPathForSelectedRow
        else {
            return
        }
        var group: Group
        let index = indexPath.row
        group = sourceController.filtering ?  sourceController.searchUserGroup[index] : sourceController.globalUserGroups[index]
        if !userGroups.contains(where: {$0.name == group.name}) {
            userGroups.append(group)
            isSearch = false
            tableView.reloadData()
        }
    }
    
    private func loadGroups(comlition: @escaping()->()) {
        //грузим каждую 3-ю загрузку или когда база пустая
        var cnt = UserDefaults.standard.integer(forKey: countLoadGroups)
        cnt = cnt + 1 == 3 ? 0 : cnt + 1
        UserDefaults.standard.set(cnt, forKey: countLoadGroups)
        if realmService.getGroups().isEmpty || cnt == 0 {
            apiService.getGroups(completion: { groups in
                self.realmService.addGroups(groups: groups)
                comlition()
            })
        } else {
            comlition()
        }
        
    }
}
