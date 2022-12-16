//
//  ViewController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/12.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: K.uploadAvatar)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.accessibilityIdentifier = TestIdentifier.plusPhotoButton
        
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.emailPlaceholder
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.accessibilityIdentifier = TestIdentifier.emailTextField
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.usernamePlaceholder
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.accessibilityIdentifier = TestIdentifier.usernameTextField
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.passwordPlaceholder
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.accessibilityIdentifier = TestIdentifier.passwordTextField
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.signButtonTitle, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.accessibilityIdentifier = TestIdentifier.signUpButton
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    //MARK: - 註冊
    @objc func handleSignUp() {
        // 1.註冊使用者
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        self.signUpButton.isEnabled = false
        self.signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let user = authResult?.user, error == nil else {
                print(error?.localizedDescription ?? "註冊失敗")
                self.signUpButton.isEnabled = false
                return
            }
            print("\(user.uid) 註冊成功")
            // 2.上傳使用者頭貼
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storage = Storage.storage()
            let storageRef = storage.reference()
            storageRef.child("profile_images").child(filename).putData(uploadData) { metadata, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                // 3.取得頭貼連結
                let ref = storageRef.child("profile_images").child(filename)
                ref.downloadURL { downloadURL, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    guard let ProfileImageUrl = downloadURL?.absoluteString else { return }
                    print(ProfileImageUrl)
                    // 4.儲存使用者名稱與頭貼連結
                    let dictionaryValues = ["username": username, "ProfileImageUrl": ProfileImageUrl]
                    let values = [user.uid: dictionaryValues]
                    
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    
                    ref.child("user").updateChildValues(values) { error, reference in
                        if let error = error {
                            print(error.localizedDescription )
                            return
                        }
                        
                        print("\(username) 儲存成功")
                    }
                    
                }
            }
            
            
        }
        
    }
    //MARK: - 檢查輸入
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty != true &&
        usernameTextField.text?.isEmpty != true &&
        passwordTextField.text?.isEmpty != true
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    //MARK: - 取得本機照片
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.label.cgColor
        plusPhotoButton.layer.borderWidth = 2
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 56, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        
    }
    
    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            usernameTextField,
            passwordTextField,
            signUpButton
        ])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 200)
    }
    
}

