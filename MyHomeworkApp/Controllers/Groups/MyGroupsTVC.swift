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
    private let networkService = NetworkService<Group>()
    private var userGroups: Results<GroupRealm>? = try? RealmService.load(typeOf: GroupRealm.self)
    private var groupsToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsSearch.delegate = self
        tableView.register(MyGroupsCell.self)
        networkServiceFunction()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsFiltered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyGroupsCell = tableView.dequeueReusableCell(for: indexPath)
            
        let myGroup = groupsFiltered[indexPath.row]

        cell.configure(
            name: myGroup.name,
            url: myGroup.avatar)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? RealmService.delete(object: groupsFiltered.remove(at: indexPath.row))
            if groupsFiltered.isEmpty { myGroupsSearch.searchTextField.text = "" }
        }
    }
    
    func networkServiceFunction() {
        networkService.fetch(type: .groups) { [weak self] result in
            switch result {
            case .success(let myGroups):
                let realmGroup = myGroups.map { GroupRealm(group: $0) }
                DispatchQueue.main.async {
                    do {
                        try? RealmService.save(items: realmGroup)
                        self?.userGroups = try RealmService.load(typeOf: GroupRealm.self)
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortGroups(_ searchText: String? = "") {
        guard let userGroups = userGroups,
              let searchText = searchText else { return }
        groupsFiltered.removeAll()
        userGroups.forEach { group in
            if !searchText.isEmpty {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    groupsFiltered.append(group)
                }
            } else {
                groupsFiltered.append(group)
            }
        }
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
        guard userGroups?.filter("id == %@", group.id).isEmpty == true else { return }
            let groupToRealm = GroupRealm(group: Group(id: group.id, name: group.name, avatar: group.avatar))
            try? RealmService.add(item: groupToRealm)
    }
}
