//
//  AllGroupsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit

class AllGroupsTVC: UITableViewController {
    @IBOutlet var allGroupsSearch: UISearchBar!
    
    private var timer = Timer()
    private let networkService = NetworkService<Group>()
    private var searchQuery = String()
    var allGroupsFiltered = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "MyGroupsCell",
            bundle: nil),
            forCellReuseIdentifier: "groupCell")
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
            name: availableGroup.name,
            url: availableGroup.avatar)
        
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

        searchQuery = searchText
        allGroupsFiltered.removeAll()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in networkServiceFunction() })
    }
    
    func  networkServiceFunction() {
        networkService.fetch(type: .groupSearch, q: searchQuery) { [weak self] result in
                switch result {
                case .success(let allGroups):
                    allGroups.forEach() { i in
                        self?.allGroupsFiltered.append(
                            Group( id: i.id,
                                   name: i.name,
                                   avatar: i.avatar))
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
