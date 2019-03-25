//
//  CommentVO.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

struct CommentVO {
	
    let body: String
	
    init(from comment: Comment) {
        guard let body = comment.body else {
            self.body = ""
            return
        }
        self.body = body
    }
    
}
