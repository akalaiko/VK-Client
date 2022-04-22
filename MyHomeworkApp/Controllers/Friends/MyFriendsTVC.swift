//
//  FriendsTableViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit
import RealmSwift

final class MyFriendsTVC: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    private var friendsDictionary = [String: [UserRealm]]()
    private var friendsSectionTitles = [String]()
    private var friendsFilteredDictionary = [String: [UserRealm]]()
    private let friendService = FriendService.instance
    var friends: [UserRealm]? {
        didSet {
            DispatchQueue.main.async { self.sortFriends()}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(MyFriendCell.self)
        friends = try? RealmService.load(type: UserRealm.self)
        tableView.sectionHeaderTopPadding = 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int { friendsSectionTitles.count }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { friendsSectionTitles }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsFilteredDictionary[friendsSectionTitles[section]]?.count ?? 0 }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        friendsSectionTitles[section] }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyFriendCell = tableView.dequeueReusableCell(for: indexPath)
        
        let letterKey = friendsSectionTitles[indexPath.section]
        guard let friendsOnLetterKey = friendsFilteredDictionary[letterKey] else { return cell }
        let myFriend = friendsOnLetterKey[indexPath.row]
        cell.configure(name: myFriend.fullName, url: myFriend.photo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        performSegue(withIdentifier: "goToFriend", sender: nil)
        searchBarCancelButtonClicked(searchBar)
    }
    
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
    
    func sortFriends() {
        guard let friends = friends else { return }
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
