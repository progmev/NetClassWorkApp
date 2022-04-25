//
//  DetailViewController.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 18.04.22.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var usernameLbl: UILabel!
    @IBOutlet private weak var emailLbl: UILabel!
    @IBOutlet private weak var phoneLbl: UILabel!
    @IBOutlet private weak var websiteLbl: UILabel!
    @IBOutlet private weak var streetLbl: UILabel!
    @IBOutlet private weak var suitLbl: UILabel!
    @IBOutlet private weak var cityLbl: UILabel!
    @IBOutlet private weak var zipCodeLbl: UILabel!

    @IBOutlet private weak var companyLbl: UILabel!
    @IBOutlet private weak var bsLbl: UILabel!
    @IBOutlet private weak var chLbl: UILabel!

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        guard let name = user?.name else { return }
        nameLbl.text = name
        usernameLbl.text = user?.username ?? "No data"
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websiteLbl.text = user?.website
        streetLbl.text = user?.address?.street
        suitLbl.text = user?.address?.suite
        cityLbl.text = user?.address?.city
        zipCodeLbl.text = user?.address?.zipcode
        companyLbl.text = user?.company?.name
        bsLbl.text = user?.company?.bs
        chLbl.text = user?.company?.catchPhrase
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPosts",
           let postsVC = segue.destination as? PostsTableViewController {
            postsVC.user = user
        } else if segue.identifier == "albomsSegue",
                  let albomsTableVC = segue.destination as? AlbomsTableVC {
            albomsTableVC.user = user
        }
    }
}
