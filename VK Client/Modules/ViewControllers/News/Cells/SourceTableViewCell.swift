//
//  SourceTableViewCell.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var dateOfPostLabel: UILabel!
    @IBOutlet weak var userName: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    func clearCell() {
        avatarImageView.image = nil
        dateOfPostLabel.text = nil
        userName.setTitle(nil, for: .normal)
    }
    override func prepareForReuse() {
      clearCell()
    }

    func configure(image: UIImage?, date: String?, name: String?) {
        if let image = image {
            avatarImageView.image = image
        }
        if let date = date {
            dateOfPostLabel.text = date
        }
        if let name = name {
            userName.setTitle(name, for: .normal)
        }
    }
    
}
