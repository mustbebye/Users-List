//
//  UsersVC.swift
//  Dem User Doe
//
//  Created by 陳宇龍 on 2019/5/26.
//  Copyright © 2019 2B2b. All rights reserved.
//

import UIKit

class UsersVC: UITableViewController {
    
    let temporaryUsers = ["Jannie", "Jessica", "Kyle L.", "Kyle N.", "Steven"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ohai")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temporaryUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = temporaryUsers[indexPath.row]
        
        cell.textLabel?.text = user
        
        return cell
    }
}
