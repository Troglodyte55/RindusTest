//
//  PostVO.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct PostVO {
	
	var id: Int
	
	var title: String?
    
    var date: String?
	
    init (with post: Post) {
        id = post.id
        title = post.title
        date = post.date
    }
    
}
