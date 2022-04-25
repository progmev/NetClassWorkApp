//
//  ApiService.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import Alamofire
import Foundation
import SwiftyJSON

class ApiService {
    
    static func deletePost(id: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        
        let url = ApiConstants.postsLocalURLString + "/" + "\(id)"
        
        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            var value: JSON?
            var err: Error?

            switch response.result {
            case .success(let a):
                value = JSON(a)
            case .failure(let error):
                err = error
            }
            callback(value, err)
        }
    }
    
    static func deleteComment(id: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        
        let url = ApiConstants.commentsLocalURLString + "/" + "\(id)"
        
        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            var value: JSON?
            var err: Error?

            switch response.result {
            case .success(let a):
                value = JSON(a)
            case .failure(let error):
                err = error
            }
            callback(value, err)
        }
    }
    
    static func fetchComments(id: Int,
                              callback: @escaping (_ result: [Comment]?, _ error: Error?) -> Void) {
        
        let urlPath = "\(ApiConstants.postsLocalURLString)/\(id)/comments"
        //"\(ApiConstants.commentsLocalURLString)?postId=\(id)"
        guard let url = URL(string: urlPath) else { return }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in

            switch response.result {
            case .success(let data):
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    callback(comments, nil)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
