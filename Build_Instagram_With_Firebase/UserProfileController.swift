//
//  UserProfileController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/16.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
//        navigationItem.title = "username"
        navigationController?.tabBarController?.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        navigationController?.tabBarController?.tabBar.layer.borderWidth = 1
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.child("user").child(userID).observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
//          let value = snapshot.value as? NSDictionary
//          let username = value?["username"] as? String ?? ""
//          let user = User(username: username)
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let username = dictionary["username"] as? String
            self.navigationItem.title = username

          // ...
        }) { error in
          print(error.localizedDescription)
        }
    }
}
