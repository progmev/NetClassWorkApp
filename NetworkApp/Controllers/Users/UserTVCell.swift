//
//  UserTVCell.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 14.04.22.
//

import UIKit

class UserTVCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    func setupUI(user: User) {
        nameLbl.text = user.name
        usernameLbl.text = user.username
    }
}
