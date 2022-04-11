//
//  FriendsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit
import RealmSwift

final class MyFriendsTVC: UITableViewController, UIGestureRecognizerDelegate {
    @IBOutlet var searchBar: UISearchBar!
    
    private var friendsDictionary = [String: [UserRealm]]()
    private var friendsSectionTitles = [String]()
    private var friendsFilteredDictionary = [String: [UserRealm]]()
    private let friendService = FriendService.instance
    private var friends = [UserRealm]() {
        didSet {
            DispatchQueue.main.async {
                self.sortFriends()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.register(MyFriendCell.self)
        friendService.networkServiceFunction { items in self.friends = items }
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        friendsSectionTitles.count 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = friendsFilteredDictionary[friendsSectionTitles[section]]?.count else { return 0 }
        return rows
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        friendsSectionTitles
    }
    
// section header & cell configure

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        friendsSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.tintColor = UIColor.gray.withAlphaComponent(0.05)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyFriendCell = tableView.dequeueReusableCell(for: indexPath)
        
        let letterKey = friendsSectionTitles[indexPath.section]
        guard let friendsOnLetterKey = friendsFilteredDictionary[letterKey] else { return cell }
        let myFriend = friendsOnLetterKey[indexPath.row]
        cell.configure(name: myFriend.fullName, url: myFriend.photo)
        return cell
    }
    
    func sortFriends() {
        for friend in friends where friend.firstName != "DELETED" {
            friendsDictionary.removeAll()

            for index in friends.indices {
                let letterKey = String((friends[index].lastName).prefix(1))
                var friendsOnLetterKey = friendsDictionary[letterKey] ?? []
                friendsOnLetterKey.append(friends[index])
                friendsDictionary[letterKey] = friendsOnLetterKey
            }
        }
        friendsSectionTitles = [String](friendsDictionary.keys).sorted()
        friendsFilteredDictionary = friendsDictionary
        self.tableView.reloadData()
    }
    
// select & segue
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any? ) {
        guard segue.identifier == "goToFriend",
                let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? FriendCVC
        else { return }
        let letterKey = friendsSectionTitles[indexPath.section]
        if let friendsOnLetterKey = friendsFilteredDictionary[letterKey] {
           destination.friend = friendsOnLetterKey[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        performSegue(withIdentifier: "goToFriend", sender: nil)
        searchBarCancelButtonClicked(searchBar)
    }
}

extension MyFriendsTVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return sortFriends() }

        friendsFilteredDictionary.removeAll()
        friendsSectionTitles.removeAll()

        for key in friendsDictionary.keys {
            guard let friend = friendsDictionary[key] else { return }
            friendsFilteredDictionary[key] = friend.filter({ $0.fullName.lowercased().contains(searchText.lowercased()) })
        }

        friendsSectionTitles = ([String](friendsFilteredDictionary.keys).sorted()).filter({ !friendsFilteredDictionary[$0]!.isEmpty })
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        sortFriends()
    }
}
