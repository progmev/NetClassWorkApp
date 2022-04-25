//
//  ImageVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import UIKit
import SwiftyJSON
import AlamofireImage
import Alamofire

class OriginImageVC: UIViewController {
    
    var photo: JSON?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = photo?["title"].string
        getPhoto()
    }
    
    func getPhoto() {
        if let photoURL = photo?["url"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                activityIndicator.stopAnimating()
                imageView.image = image
            } else {
                AF.request(photoURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.imageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
                    }
                }
            }
        }
    }
}
