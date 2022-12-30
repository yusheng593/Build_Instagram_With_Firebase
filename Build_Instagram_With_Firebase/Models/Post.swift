//
//  Post.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/30.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
