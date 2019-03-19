//
//  CommentDTO.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct CommentDTO: Codable {
	
	var id: Int
	
	var body: String?
	
	var postId: Int
	
}
