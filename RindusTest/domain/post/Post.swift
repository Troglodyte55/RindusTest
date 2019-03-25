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
    
    var date: String?
	
	var comments: [Comment]?
	
	init(from dto: PostDTO) {
		id = dto.id
		title = dto.title
        date = dto.date
	}
    
    init (from vo: PostVO) {
        id = vo.id
        title = vo.title
        date = vo.date
    }
	
}
