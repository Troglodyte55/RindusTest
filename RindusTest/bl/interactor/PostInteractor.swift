//
//  PostInteractor.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

protocol PostInteractorAction {
	
    init(with delegate: PostInteractorDelegate)
    
	func getPosts()
	
}

protocol PostInteractorDelegate: class {
	
	func onPostsLoaded(posts: [Post])
	
	func onPostsFailure(error: Error)
	
}

class PostInteractor: PostInteractorAction {
	
	var delegate: PostInteractorDelegate?
	
    lazy var repository: PostRepositoryAction = {
        return PostRepository(with: self)
    }()
	
    required init(with delegate: PostInteractorDelegate) {
        self.delegate = delegate
    }
	
	func getPosts() {
		repository.getPosts()
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
