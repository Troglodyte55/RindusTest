//
//  PostVO.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct PostVO {
	
	let id: Int
	
    let title: String
    
    let date: String
	
    init (with post: Post) {
        id = post.id
        if let postTitle = post.title {
            title = postTitle
        } else {
            title = "Title unknown"
        }
        if let postDate = post.date {
            date = postDate
        } else {
            date = "Date unknown"
        }
    }
    
}
