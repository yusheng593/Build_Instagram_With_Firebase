//
//  Post.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/30.
//

import Foundation

struct Post {
    let imageUrl: String
    let user: User
    let caption: String
    
    init(dictionary: [String: Any], user: User) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
