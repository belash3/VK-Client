//
//  UtilityTableViewCell.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit

class UtilityTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        clearCell()
    }

    func clearCell() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeLabel.text = nil
        commentLabel.text = nil
        repostLabel.text = nil
        viewsLabel.text = nil
    }

    func configure(likes: String?, comments: String?,
                   reposts: String?, views: String?) {
        if let likes = likes {
            likeLabel.text = likes
        }
        if let comments = comments {
            commentLabel.text = comments
        }
        if let reposts = reposts {
            repostLabel.text = reposts
        }
        if let views = views {
            viewsLabel.text = views
        }
    }
    
}
