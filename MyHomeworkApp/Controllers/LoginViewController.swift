//
//  ViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 15.12.2021.
//

import UIKit

class LoginViewController: UIViewController {
       
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var groupsForUse = [GroupRealm]()
    var usersForUse = [UserRealm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        
        let getGroups = GroupsService()
        let getFriends = FriendService()
        
        queue.addOperation(getGroups)
        queue.addOperation(getFriends)

        queue.addBarrierBlock {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToMain", sender: nil)
            }
        }
    }
}



