//
//  UserGroupsTableViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
//

import UIKit

class UserGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    private var userGroups = [Group]()
//    private var fillFakeData = FillFakeData()
    private var foundUserGroup = [Group]()
    private var isSearch = false
    @IBOutlet weak var searchBar: UISearchBar!
    private let apiService = APIService()
    
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
//        fillFakeData.fillUserGroup(arr: &userGroups)
        apiService.getGroups { groups in
            self.userGroups = groups
            self.tableView.reloadData()
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
//            group.addUser()
            userGroups.append(group)
            isSearch = false
            tableView.reloadData()
        }
    }
}
