//
//  AddPostVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 18.04.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddPostVC: UIViewController {
    
    @IBOutlet weak var titleForPostTF: UITextField!
    @IBOutlet weak var bodyForPostTV: UITextView!
    
    var user: User!
    var post: Post?
    
    var delegate: PostsTableVCProtocol?
    
    override func viewDidLoad() {
        // edit logic
        titleForPostTF.text = post?.title
        bodyForPostTV.text = post?.body
    }
    
    @IBAction func addNewPostURLSession() {
        
        if let title = titleForPostTF.text,
           let body = bodyForPostTV.text,
           let url = ApiConstants.postsLocalURL {
            
            // 1 Request
            var request = URLRequest(url: url)
            
            // 2 Header for Request
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // 3 Body
            let body: [String : Any] = ["userId": user.id,
                                        "title": title,
                                        "body": body]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    print(error)
                } else if let data = data {
                    print(data)
                    guard let json = try? JSON(data: data) else { return }
                    print(json)
                    print(json["userId"])
                    print(json["id"])
                    print(json["title"])
                    print(json["body"])
                    
                    DispatchQueue.main.async {
                        self?.delegate?.newPostAdded()
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func AddNewPostWithAF() {
        if let title = titleForPostTF.text,
           let body = bodyForPostTV.text,
           let url = ApiConstants.postsLocalURL {
            // 1 Body
            let body: Parameters = ["userId": user.id,
                                    "title": title,
                                    "body": body]
            
            // 2 request
            
            AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
                .responseData { [weak self] dataResponse in
                    print(dataResponse)
                    print(dataResponse.request)
                    print(dataResponse.response)
                    print(dataResponse.result)
                    
                    switch dataResponse.result {
                        case .success(let data):
                            print(data)
                            print(JSON(data))
                            self?.delegate?.newPostAdded()
                            self?.navigationController?.popViewController(animated: true)
                        case .failure(let error):
                            print(error)
                    }
                }
        }
    }
}
