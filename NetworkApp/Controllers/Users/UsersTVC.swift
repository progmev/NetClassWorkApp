//
//  UsersTVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 14.04.22.
//

import UIKit

protocol UsersTVCProtocol {
    func fetchData()
}

class UsersTVC: UITableViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserTVCell else { return UITableViewCell() }
        cell.setupUI(user: users[indexPath.row])
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: user)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? DetailViewController,
           let user = sender as? User
        {
            desination.user = user
        }
    }
}

extension UsersTVC: UsersTVCProtocol {
    func fetchData() {
        
        guard let url = URL(string: ApiConstants.usersURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error { print(error) }
            
            guard let data = data else { return }
            
            do {
                self?.users = try JSONDecoder().decode([User].self, from: data)
                print(self?.users ?? "")
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        task.resume()
    }
}
