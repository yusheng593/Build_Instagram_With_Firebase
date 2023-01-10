//
//  HomeController.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2023/1/9.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: K.cellId)
        
        fetchOrderedPosts()
    }
    
    fileprivate func setupView() {
        collectionView.backgroundColor = .systemBackground
        navigationController?.tabBarController?.tabBar.layer.borderColor = UIColor.systemGray6.cgColor
        navigationController?.tabBarController?.tabBar.layer.borderWidth = 1
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
    }
    
    var posts = [Post]()
    
    fileprivate func fetchOrderedPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let post = Post(dictionary: dictionary)
            self.posts.append(post)
            
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellId, for: indexPath) as! HomePostCell
        
        cell.post = self.posts[indexPath.item]
        
        return cell
    }
    
}
