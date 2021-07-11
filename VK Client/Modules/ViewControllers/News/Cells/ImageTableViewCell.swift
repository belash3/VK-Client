//
//  ImageTableViewCell.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    func clearCell() {
        imageView?.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage?) {
        if let image = image {
            newsImage.image = image
        }
    }
}
