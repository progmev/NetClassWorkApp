//
//  PhotosCollectionVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import UIKit
import SwiftyJSON
import Alamofire

private let reuseIdentifier = "Cell"

class PhotosCollectionVC: UICollectionViewController {
    
    var user: User?
    var album: JSON?
    
    var photos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?["title"].string
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 3 - 15
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageVC = segue.destination as? OriginImageVC,
           let photo = sender as? JSON {
            imageVC.photo = photo
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? PhotoCollectionViewCell
        else { return UICollectionViewCell() }
        cell.photo = photos[indexPath.row]
        cell.getThumbnail()
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    private func getData() {
        if let album = album,
           let albumID = album["id"].int,
           let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumID)")
        {
            AF.request(url).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    self.photos = JSON(data).arrayValue
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
