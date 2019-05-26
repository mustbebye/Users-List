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
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    func getUsers() {
        // https://jsonplaceholder.typicode.com/
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            if let error = error {
                print(error)
            } else if let data = data {
                print(data)
                
//                let dataString = String(data: data, encoding: .utf8)
//                print(dataString)
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
                    
                    var users = [User]()
                    
                    for userDictionary in json {
                        guard
                            let name = userDictionary["name"] as? String,
                            let address = userDictionary["address"] as? [String: Any],
                            let city = address["city"] as? String
                            else { return }
                        
                        let user = User(name: name, city: city)
                        users.append(user)
                    }
                    
                    print(users)
                    
                    self.users = users
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let err{
                    print(err)
                }
            }
        }
        dataTask.resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.city
        
        return cell
    }
}
