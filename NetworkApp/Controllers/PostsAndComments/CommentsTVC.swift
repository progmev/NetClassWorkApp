//
//  CommentsTVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var postId: Int!
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        fetchComments()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.name

        return cell
    }
    
    private func fetchComments() {
        ApiService.fetchComments(id: postId) { [weak self] result, error in
            if let result = result {
                self?.comments = result
                self?.tableView.reloadData()
            }
        }
    }
}
