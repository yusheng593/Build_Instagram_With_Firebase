//
//  UserProfileHeader.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/18.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            setupProfileImage()
            self.username.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var username: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        profileImageView.clipsToBounds = true
        
        addSubview(username)
        username.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
    }
    
    
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else {
            return }
        guard let url = URL(string: profileImageUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("取得用戶頭貼失敗", error.localizedDescription)
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
