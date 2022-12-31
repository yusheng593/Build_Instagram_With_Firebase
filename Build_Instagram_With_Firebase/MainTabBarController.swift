//
//  MainTabBarController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/16.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 3 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                
                #if DEBUG
                if ProcessInfo.processInfo.arguments.contains("toTestSignUpController") {
                    let loginController = SignUpController()
                    let navController = UINavigationController(rootViewController: loginController)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: false)
                }
                #endif
                
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: false)
            }
            return
        }
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        let homeNavController = templateNavController(unselectedImage: "home_unselected", selectedImage: "home_selected")
        let searchNavController = templateNavController(unselectedImage: "search_unselected", selectedImage: "search_selected")
        let plusNavController = templateNavController(unselectedImage: "plus_unselected", selectedImage: "plus_unselected")
        let likeNavController = templateNavController(unselectedImage: "like_unselected", selectedImage: "like_selected")
        
        // user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = UIImage(named: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .label
        
        viewControllers = [userProfileNavController, homeNavController, searchNavController, plusNavController, likeNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: String, selectedImage: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: unselectedImage)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        return navController
    }
    
}
