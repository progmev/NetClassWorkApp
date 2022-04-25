//
//  PhotoCollectionViewCell.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImage: UIImageView!
    
    var photo: JSON!
    
    func getThumbnail() {
        activityIndicator.startAnimating()
        if let thumbnailURL = photo["thumbnailUrl"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                photoImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}
