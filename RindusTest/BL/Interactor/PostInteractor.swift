//
//  PostInteractor.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

protocol PostInteractorAction {
	
	func getPosts()
	
}

protocol PostInteractorDelegate: class {
	
}

class PostInteractor: PostInteractorAction {
	
	var repository: PostRepositoryAction
	
	init() {
		self.repository = PostRepository()
	}
	
	func getPosts() {
		self.repository.getPosts()
	}
	
}
