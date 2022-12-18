//
//  UserProfileHeader.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/18.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        profileImageView.clipsToBounds = true
        
    }
    
    var user: User? {
        didSet {
            setupProfileImage()
        }
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
