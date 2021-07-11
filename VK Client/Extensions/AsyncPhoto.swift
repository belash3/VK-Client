//
//  AsyncPhoto.swift
//  VK Client
//
//  Created by Сергей Беляков on 10.07.2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIViewController {
   
    func asyncPhoto(cellImage: UIImageView, url: URL) -> UIImage {
      var asyncImage = UIImage()
      cellImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
      cellImage.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cache, urls) in
                  if (error != nil) {
                    asyncImage = UIImage(named: "logo")!
                  } else {
                    asyncImage = image!
                  }
              })
      return asyncImage
    }
    
}
