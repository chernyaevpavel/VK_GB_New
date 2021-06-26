//
//  GlobalGroupsTableViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
//

import UIKit

class GlobalGroupsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var globalUserGroups = [Group]()
    var searchUserGroup = [Group]()
    private let fillFakeData = FillFakeData()
    private let searchController = UISearchController()
    private var isEmptySearchText: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    var filtering: Bool {
        return searchController.isActive && !isEmptySearchText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fillFakeData.fillGlobalGroup(arr: &globalUserGroups)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtering ?  searchUserGroup.count : globalUserGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupTableViewCell.reuseID, for: indexPath) as! UserGroupTableViewCell
        let index = indexPath.row
        var group: Group
        group = filtering ? searchUserGroup[index] : globalUserGroups[index]
        cell.configure(group)
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if isEmptySearchText {
            searchUserGroup = globalUserGroups
        } else {
            searchUserGroup = globalUserGroups.filter({$0.name.lowercased().contains(text.lowercased()) })
        }
        tableView.reloadData()
    }
}
