//
//  GroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit

final class MyGroupsTVC: UITableViewController {
    
    
    @IBOutlet var myGroupsSearch: UISearchBar!
    
    var groupsFiltered = [Group]()
    private let networkService = NetworkService()
    var userGroups = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.groupsFiltered = self.userGroups
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsSearch.delegate = self
        tableView.register(UINib(
            nibName: "MyGroupsCell",
            bundle: nil),
            forCellReuseIdentifier: "groupCell")
        
        networkService.fetchGroups() { [weak self] result in
            switch result {
            case .success(let myGroups):
                myGroups.items.forEach() { i in
                    self?.userGroups.append(Group(
                        name: i.name,
                        avatar: i.avatar))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        groupsFiltered = userGroups

        
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
//        userGroups.append(availableGroups.remove(at: availableGroups.firstIndex(of: group)!))
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
            name: myGroup.name,
            url: myGroup.avatar ?? "")
       
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeGroup = groupsFiltered.remove(at: indexPath.row)
//            availableGroups.append(removeGroup)
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
