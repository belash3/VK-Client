//
//  CustomPhotoCollectionViewCell.swift
//  VK Client
//
//  Created by Сергей Беляков on 10.06.2021.
//

import UIKit

class CustomPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    func clearCell() {
        photoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    func configure( image: UIImage?) {
        if let image = image {
            photoImageView.image = image
        }
        
    }
}
