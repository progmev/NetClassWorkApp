//
//  PostsTableViewController.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 18.04.22.
//

import UIKit

protocol PostsTableVCProtocol {
    func newPostAdded()
    func postUpdated()
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

    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            guard let id = self?.posts[indexPath.row].id else { return }
            ApiService.deletePost(id: id) { [weak self] result, error in
//                self?.fetchPosts()
                if let _ = result {
                    self?.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
        let updateItem = UIContextualAction(style: .normal, title: "Update") { [weak self]  (contextualAction, view, boolValue) in
            let post = self?.posts[indexPath.row]
            self?.performSegue(withIdentifier: "addPost", sender: post)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, updateItem])

        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].id
        performSegue(withIdentifier: "showComments", sender: postId)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComments",
           let postId = sender as? Int,
           let commentsTVC = segue.destination as? CommentsTVC {
            commentsTVC.postId = postId
        } else if segue.identifier == "addPost",
                  let addPostVC = segue.destination as? AddPostVC {
            addPostVC.user = user
            addPostVC.delegate = self
            guard let post = sender as? Post else {
                return
            }
            addPostVC.post = post
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
    
    func postUpdated() {
        fetchPosts()
    }
    
    func newPostAdded() {
        fetchPosts()
    }
    
}
