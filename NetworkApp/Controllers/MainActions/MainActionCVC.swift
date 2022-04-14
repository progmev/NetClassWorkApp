//
//  MainActionCVC.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 11.04.22.
//

import UIKit

enum UserActions: String, CaseIterable {
    case dowloadImage = "Download image"
    case users = "Users"
}

class MainActionCVC: UICollectionViewController {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let usersTVC = segue.destination as? UsersTVCProtocol else { return }
        usersTVC.fetchData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserActions.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActionCVCell
        cell.actionLbl.text = UserActions.allCases[indexPath.item].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userAction = UserActions.allCases[indexPath.item]
        
        switch userAction {
            case .dowloadImage: performSegue(withIdentifier: "showImageVC", sender: nil)
            case .users:        performSegue(withIdentifier: "showUsersTVC", sender: nil)
        }
    }
}

extension MainActionCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}
