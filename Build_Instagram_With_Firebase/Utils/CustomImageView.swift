//
//  CustomImageView.swift
//  Build_Instagram_With_Firebase
//
//  Created by yusheng Lu on 2022/12/30.
//

import UIKit

class CustomImageView: UIImageView {
    var lastURLUsedLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedLoadImage = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch post image:", error.localizedDescription)
            }
            // 避免載入錯誤圖片
            if url.absoluteString != self.lastURLUsedLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
