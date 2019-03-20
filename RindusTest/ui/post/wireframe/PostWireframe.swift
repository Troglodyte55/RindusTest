//
//  PostWireframe.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

class PostWireframe {
	
	static func createModule() -> PostViewController {
		let presenter = PostPresenter()
		let view = PostViewController(with: presenter)
        presenter.ui = view
		return view
	}
	
}
