//
//  User.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2023/1/11.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    
    init(username: String, profileImageUrl: String) {
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
}
