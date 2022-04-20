//
//  ApiConstants.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 11.04.22.
//

import Foundation

final class ApiConstants {
    
    // MARK: - Rmout URL
    
    // image URL
    static let imageURL = "https://peoplelovescience.com/wp-content/uploads/2017/08/dsc4081-cc.jpg"
    // base URL
    static let baseURL = "https://jsonplaceholder.typicode.com"
    // users URL
    static let usersURL = baseURL + "/users"
    
    // MARK: - Local URL
    
    // base local URL
    static let baseLocalURLString = "http://localhost:3000/"
    // posts
    static let postsLocalURLString = baseLocalURLString + "posts"
    static let postsLocalURL = URL(string: postsLocalURLString)
    // comments
    static let commentsLocalURLString = baseLocalURLString + "comments"
    static let commentsLocalURL = URL(string: commentsLocalURLString)
}
