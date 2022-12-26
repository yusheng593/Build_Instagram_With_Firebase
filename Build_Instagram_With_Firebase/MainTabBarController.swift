//
//  MainTabBarController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/16.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginController()
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: false)
            }
        } else {
            let layout = UICollectionViewFlowLayout()
            let userProfileController = UserProfileController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: userProfileController)
            viewControllers = [navController, UIViewController()]
            
            navController.tabBarItem.image = UIImage(named: "profile_unselected")
            navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
            tabBar.tintColor = .label
        }
        
        
        
    }
    
}