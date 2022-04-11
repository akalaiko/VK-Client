//
//  GroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit
import RealmSwift

final class MyGroupsTVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var myGroupsSearch: UISearchBar!
    
    private var groupsFiltered = [GroupRealm]()
    private let groupsService = GroupsService.instance
    private var userGroups = [GroupRealm]() {
        didSet {
            DispatchQueue.main.async {
                self.sortGroups()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsSearch.delegate = self
        tableView.register(MyGroupsCell.self)
        groupsService.networkServiceFunction { items in self.userGroups = items }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsFiltered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyGroupsCell = tableView.dequeueReusableCell(for: indexPath)
        let myGroup = groupsFiltered[indexPath.row]

        cell.configure(name: myGroup.name, url: myGroup.avatar)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? RealmService.delete(object: groupsFiltered.remove(at: indexPath.row))
            if groupsFiltered.isEmpty { myGroupsSearch.searchTextField.text = "" }
        }
    }
    
    func sortGroups(_ searchText: String? = "") {
        guard let searchText = searchText else { return }
        groupsFiltered.removeAll()
        groupsFiltered = searchText.isEmpty ? userGroups : userGroups.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortGroups(searchText)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard segue.identifier == "addGroup",
              let allGroupsController = segue.source as? AllGroupsTVC,
              let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = allGroupsController.allGroupsFiltered[groupIndexPath.row]
        guard userGroups.filter({$0.id == group.id}).isEmpty == true else { return }
        userGroups.append(GroupRealm(group: group))
    }
}
