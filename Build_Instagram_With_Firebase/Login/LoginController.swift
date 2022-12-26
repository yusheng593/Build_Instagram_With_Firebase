//
//  LoginController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/26.
//

import UIKit

class LoginController: UIViewController {
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account?  Sign Up.", for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowSignUp() {
        let vc = SignUpController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -16, paddingRight: 0, width: 0, height: 50)
    }
}
