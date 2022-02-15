//
//  AllGroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit

class AllGroupsTVC: UITableViewController {
    @IBOutlet var allGroupsSearch: UISearchBar!
    var allGroupsFiltered = [GroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "MyGroupsCell",
            bundle: nil),
            forCellReuseIdentifier: "groupCell")
        
        allGroupsFiltered = availableGroups
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroupsFiltered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        
        let availableGroup = allGroupsFiltered[indexPath.row]

        cell.configure(
            avatar: availableGroup.avatar,
            name: availableGroup.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
        performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }
}

extension AllGroupsTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            allGroupsFiltered = availableGroups
            tableView.reloadData()
            return
        }
        allGroupsFiltered = availableGroups.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
    
}
