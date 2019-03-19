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
	
	func onPostsLoaded(posts: [Post])
	
	func onPostsFailure(error: Error)
	
}

class PostInteractor: PostInteractorAction {
	
	var delegate: PostInteractorDelegate?
	
	var repository: PostRepositoryAction
	
	init() {
		self.repository = PostRepository()
	}
	
	func getPosts() {
		self.repository.getPosts()
	}
	
}

extension PostInteractor: PostRepositoryDelegate {
	
	func didPostsLoadedFailure(error: Error) {
		guard let delegate = delegate else {
			print ("PostInteractor.didPostsLoadedFailure - There are not delegate designated")
			return
		}
		delegate.onPostsFailure(error: error)
	}
	
	func didPostsLoadedSuccess(posts: [Post]) {
		guard let delegate = delegate else {
			print ("PostInteractor.didPostsLoadedSuccess - There are not delegate designated")
			return
		}
		delegate.onPostsLoaded(posts: posts)
	}
	
}
