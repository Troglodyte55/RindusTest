//
//  Comment.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct Comment {
	
	var id: Int
	
	var body: String?
	
	var postId: Int
	
    init(from dto: CommentDTO) {
        id = dto.id
        body = dto.body
        postId = dto.postId
    }
}
