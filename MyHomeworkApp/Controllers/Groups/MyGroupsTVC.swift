//
//  GroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit
import RealmSwift

final class MyGroupsTVC: UITableViewController {
    
    @IBOutlet var myGroupsSearch: UISearchBar!
    
    var groupsFiltered = [GroupRealm]()
    private let networkService = NetworkService()
    var userGroups: Results<GroupRealm>? = try? RealmService.load(typeOf: GroupRealm.self){
        didSet {
            DispatchQueue.main.async { [self] in
                
                guard let userGroups = userGroups else {
                    return
                }
                for group in userGroups where group.name != "DELETED" {
                    groupsFiltered.append(group)
                    self.tableView.reloadData()
                }
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
                let realmGroup = myGroups.items.map { GroupRealm(group: $0) }
                DispatchQueue.main.async {
                    do {
                    try RealmService.save(items: realmGroup)
                    self?.userGroups = try RealmService.load(typeOf: GroupRealm.self)
                    self?.tableView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        guard
//            segue.identifier == "addGroup",
//            let allGroupsController = segue.source as? AllGroupsTVC,
//            let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow
//        else { return }
//        let group = allGroupsController.allGroupsFiltered[groupIndexPath.row]
//        print(groupIndexPath)
//        print(group)
////        userGroups.append(availableGroups.remove(at: availableGroups.firstIndex(of: group)!))
//        groupsFiltered = userGroups
//        tableView.reloadData()
//    }

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
            url: myGroup.avatar)
       
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeGroup = groupsFiltered.remove(at: indexPath.row)
            DispatchQueue.main.async {
                do {
                    try RealmService.delete(object: removeGroup)
                } catch {
                    print(error)
                }
            }
            tableView.reloadData()
        }
    }
}

extension MyGroupsTVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            groupsFiltered.removeAll()
            guard let userGroups = userGroups else {
                return
            }
            for group in userGroups where group.name != "DELETED" {
                groupsFiltered.append(group)
            }
            tableView.reloadData()
            return
        }

        guard let userGroups = userGroups else {
            return
        }
        groupsFiltered.removeAll()
        for group in userGroups where group.name.lowercased().contains(searchText.lowercased()) {
            groupsFiltered.append(group)
        }
        tableView.reloadData()
    }

    func searchBar (_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
    }
}
