//
//  PostCommentTableViewCell.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/24/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit



class PostCommentTableViewCell: UITableViewCell {

	/// Class var
	public static let identifier = "PostCommentTableViewCell"
	
	/// Outlets
	@IBOutlet weak var commentLabel: UILabel!
	
	/// Properties
	var comment: CommentVO!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        loadStyle()
    }
    
    private func loadStyle() {
        commentLabel.font = .systemFont(ofSize: 13, weight: .medium)
        commentLabel.textColor = .darkGray
        commentLabel.numberOfLines = 0
    }
	
	func loadCell(with comment: CommentVO) {
		self.comment = comment
		commentLabel.text = comment.body
	}

}
