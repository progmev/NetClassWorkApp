//
//  AlbomsTableVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class AlbomsTableVC: UITableViewController {
    
    var user: User?
    var alboms: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alboms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = alboms[indexPath.row]["title"].stringValue
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = alboms[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: albom)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let photosCollectionVC = segue.destination as? PhotosCollectionVC,
            let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }
    
    private func getData() {

        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                self.alboms = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
