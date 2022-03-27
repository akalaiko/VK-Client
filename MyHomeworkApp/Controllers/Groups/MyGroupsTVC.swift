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
    private var groupsFiltered = [GroupRealm]()
    private let networkService = NetworkService()
    private var userGroups: Results<GroupRealm>? = try? RealmService.load(typeOf: GroupRealm.self)
    
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
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        sortGroups()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupsToken = userGroups?.observe { [weak self] groupsChanges in
            guard let self = self else { return }
            switch groupsChanges {
            case .initial, .update:
                self.sortGroups()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        groupsToken?.invalidate()
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? AllGroupsTVC,
            let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = allGroupsController.allGroupsFiltered[groupIndexPath.row]
        guard let existingGroup = userGroups?.filter("id == %@", group.id),
              existingGroup.isEmpty
        else { return }
        let groupToRealm = GroupRealm(group: GroupData(id: group.id, name: group.name, avatar: group.avatar ?? ""))
        try? RealmService.add(item: groupToRealm)
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
            url: myGroup.avatar)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeGroup = groupsFiltered.remove(at: indexPath.row)
                    try? RealmService.delete(object: removeGroup)
        }
    }
    
    func sortGroups() {
        guard let userGroups = userGroups else { return }
        self.groupsFiltered.removeAll()
        for group in userGroups {
            groupsFiltered.append(group)
            self.tableView.reloadData()
        }
    }
}

extension MyGroupsTVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            sortGroups()
            return
        }

        guard let userGroups = userGroups else { return }
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
