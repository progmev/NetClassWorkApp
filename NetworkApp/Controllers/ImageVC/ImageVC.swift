//
//  ImageVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 11.04.22.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        
        guard let url = URL(string: ApiConstants.imageURL) else { return }
        
        let session = URLSession.shared // синглтон
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                print(response.debugDescription)
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.activityIndicatorView.stopAnimating()
                    self?.imageView.image = image
                }
            }
        }
        task.resume()
    }
}
