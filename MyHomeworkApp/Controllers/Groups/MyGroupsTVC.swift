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
    
    private var groupsToken: NotificationToken?
    var groupsFiltered = [GroupRealm]()
    private let networkService = NetworkService()
    var userGroups: Results<GroupRealm>? = try? RealmService.load(typeOf: GroupRealm.self)
    {
        didSet {
            DispatchQueue.main.async { [self] in
                guard let userGroups = userGroups else { return }
                for group in userGroups {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupsToken = userGroups?.observe { [weak self] groupsChanges in
            guard let self = self else { return }
            switch groupsChanges {
            case .initial(_):
                self.tableView.reloadData()
            case let .update(
                _,
                deletions: deletions,
                insertions: insertions,
                modifications: modifications):
                self.tableView.beginUpdates()
                
                let delRowsIndex = deletions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let insertRowsIndex = insertions.map { IndexPath(
                    row: $0,
                    section: 0)}
                let modificationIndex = modifications.map { IndexPath(
                    row: $0,
                    section: 0)}
                
                self.tableView.deleteRows(at: delRowsIndex, with: .automatic)
                self.tableView.insertRows(at: insertRowsIndex, with: .automatic)
                self.tableView.reloadRows(at: modificationIndex, with: .automatic)
                
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        groupsToken?.invalidate()
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
