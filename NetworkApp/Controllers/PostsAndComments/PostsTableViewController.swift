//
//  PostsTableViewController.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 18.04.22.
//

import UIKit

protocol PostsTableVCProtocol {
    func newPostAdded()
}

class PostsTableViewController: UITableViewController {
    
    var user: User!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // Delete запрос на сервак
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? AddPostVC {
            destVC.user = user
            destVC.delegate = self
        }
    }
    
    private func fetchPosts() {
        let id = user.id
        
        let urlPath = "\(ApiConstants.postsLocalURLString)?userId=\(id)"
        guard let url = URL(string: urlPath) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    self?.posts = try JSONDecoder().decode([Post].self, from: data)
//                    print(self?.posts)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}

extension PostsTableViewController: PostsTableVCProtocol {
    func newPostAdded() {
        fetchPosts()
    }
}
