//
//  Post.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct Post {
	
	var id: Int
	
	var title: String?
	
	var comments: [Comment]?
	
	init(from dto: PostDTO) {
		self.id = dto.id
		self.title = dto.title
	}
	
}
