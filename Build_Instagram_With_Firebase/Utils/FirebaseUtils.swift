//
//  FirebaseUtils.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2023/1/11.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        let userRef = Database.database().reference().child(Child.user).child(uid)
        userRef.observeSingleEvent(of: .value) { snapshot in
            
            let value = snapshot.value as? NSDictionary
            let user = User(uid: uid, username: value?["username"] as? String ?? "", profileImageUrl: value?["ProfileImageUrl"] as? String ?? "")
            
            completion(user)
        }
    }
    
    static func fetchPostsWithUser(user: User, completion: @escaping (Post) -> ()) {
        let ref = Database.database().reference().child(Child.posts).child(user.uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let post = Post(dictionary: dictionary, user: user)
            
            completion(post)
        }
    }
    
}
