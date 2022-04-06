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
    private let networkService = NetworkService<User>()
    private var friendsToken: NotificationToken?
    private var friends: Results<UserRealm>? = try? RealmService.load(typeOf: UserRealm.self) {
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
        networkServiceFunction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        friendsToken = friends?.observe { [weak self] friendsChanges in
            guard let self = self else { return }
            switch friendsChanges {
            case .initial, .update:
                self.sortFriends()
            case .error(let error):
                print(error)
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        friendsToken?.invalidate()
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
        return friendsSectionTitles
    }
    
// section header & cell configure

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
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

           cell.configure(
               name: myFriend.fullName,
               url: myFriend.photo)
        
        return cell
    }
    
    func networkServiceFunction() {
        networkService.fetch(type: .friends) { [weak self] result in
            switch result {
            case .success(let responseFriends):
                    let items = responseFriends.map { UserRealm(user: $0) }
                DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: items)
                        self?.friends = try RealmService.load(typeOf: UserRealm.self)
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
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
        defer { tableView.deselectRow(at: indexPath, animated: true)}
        performSegue(withIdentifier: "goToFriend", sender: nil)
        searchBarCancelButtonClicked(searchBar)
    }

}

// search

extension MyFriendsTVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return sortFriends() }

        friendsFilteredDictionary.removeAll()
        friendsSectionTitles.removeAll()

        for key in friendsDictionary.keys {
            guard let friend = friendsDictionary[key] else { return }
            friendsFilteredDictionary[key] = friend.filter({ $0.fullName.lowercased().contains(searchText.lowercased()) })
        }

        friendsSectionTitles = ([String](friendsFilteredDictionary.keys).sorted())
                                .filter({ !friendsFilteredDictionary[$0]!.isEmpty })
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        sortFriends()
    }

}
