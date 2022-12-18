//
//  UserProfileController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/16.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        navigationController?.tabBarController?.tabBar.layer.borderColor = UIColor.systemGray6.cgColor
        navigationController?.tabBarController?.tabBar.layer.borderWidth = 1
        
        fetchUser()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    
    var user: User?
    fileprivate func fetchUser() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.child("user").child(userID).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.user = User(username: value?["username"] as? String ?? "", profileImageUrl: value?["ProfileImageUrl"] as? String ?? "")
            self.navigationItem.title = self.user?.username
            self.collectionView.reloadData()
            
        }) { error in
          print(error.localizedDescription)
        }
    }
}

struct User {
    let username: String
    let profileImageUrl: String
    
    init(username: String, profileImageUrl: String) {
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
}
