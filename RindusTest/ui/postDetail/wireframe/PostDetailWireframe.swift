//
//  PostDetailWireframe.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 20/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

class PostDetailWireframe {
    
    static func createModule(with post: PostVO) -> PostDetailViewController {
        let presenter = PostDetailPresenter(with: post)
        let view = PostDetailViewController(with: presenter)
        return view
    }
    
}
