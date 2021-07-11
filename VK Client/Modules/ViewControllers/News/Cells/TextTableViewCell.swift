//
//  TextTableViewCell.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    func clearCell() {
        newsTextLabel.text = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }

    func configure(newsText: String?) {
        if let newsText = newsText {
            newsTextLabel.text = newsText
        }
    }
    
}
