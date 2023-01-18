//
//  Constants.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/13.
//

import Foundation

struct K {
    // Sign up page
    static let uploadAvatar = "plus_photo"
    static let emailPlaceholder = "請輸入信箱"
    static let usernamePlaceholder = "請輸入用戶名"
    static let passwordPlaceholder = "請輸入密碼"
    static let signButtonTitle = "註冊"
    static let loginButtonTitle = "登入"
    // Cell & Header
    static let cellId = "cellId"
    static let headerId = "headerId"
}

struct TestIdentifier {
    // Sign up and Login page
    static let plusPhotoButton = "plusPhotoButton"
    static let emailTextField = "emailTextField"
    static let usernameTextField = "usernameTextField"
    static let passwordTextField = "passwordTextField"
    static let signUpButton = "signUpButton"
    static let loginButton = "loginButton"
    static let alreadyHaveAccountButton = "alreadyHaveAccountButton"
    static let dontHaveAccountButton = "dontHaveAccountButton"
}

struct Child {
    // Firebase
    static let user = "user"
    static let posts = "posts"
    static let profile_images = "profile_images"
    static let following = "following"
}
