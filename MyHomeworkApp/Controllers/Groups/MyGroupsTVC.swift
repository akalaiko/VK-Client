//
//  GroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit

class MyGroupsTVC: UITableViewController {
    
    
    @IBOutlet var myGroupsSearch: UISearchBar!
    
    var groupsFiltered = [GroupModel]() 
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsSearch.delegate = self
        tableView.register(UINib(
            nibName: "MyGroupsCell",
            bundle: nil),
            forCellReuseIdentifier: "groupCell")
        
        groupsFiltered = userGroups
        networkService.fetchGroups()
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? AllGroupsTVC,
            let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = allGroupsController.allGroupsFiltered[groupIndexPath.row]
        print(groupIndexPath)
        print(group)
        userGroups.append(availableGroups.remove(at: availableGroups.firstIndex(of: group)!))
        groupsFiltered = userGroups
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsFiltered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
            
        let myGroup = groupsFiltered[indexPath.row]

        cell.configure(
            avatar: myGroup.avatar,
            name: myGroup.name)
       
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeGroup = groupsFiltered.remove(at: indexPath.row)
            availableGroups.append(removeGroup)
            userGroups.remove(at: userGroups.firstIndex(where: {$0.name == removeGroup.name})!)

            if userGroups.filter({ $0.name.lowercased().contains(((myGroupsSearch.searchTextField.text!.lowercased()))) }).isEmpty {
                myGroupsSearch.searchTextField.text = ""
            }
            searchBar(myGroupsSearch, textDidChange: myGroupsSearch.searchTextField.text!)
        }
    }
    
}

extension MyGroupsTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            groupsFiltered = userGroups
            tableView.reloadData()
            return
        }
        groupsFiltered = userGroups.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
    
    func searchBar (_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
    }
}
