//
//  PostInteractor.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

// MARK: - Post Interactor Action
protocol PostInteractorAction {
	
    init(with delegate: PostInteractorDelegate)
    
	func getPosts()
	
}

// MARK: - Post Interactor Delegate
protocol PostInteractorDelegate: class {
	
	func onPostsLoadedSuccess(posts: [Post])
	
	func onPostsLoadedFailure(error: Error)
	
}

// MARK: - Post Interactor Implementation
class PostInteractor: PostInteractorAction {
	
	weak var delegate: PostInteractorDelegate?
	
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

// MARK: - Post Repository Delegate implementation
extension PostInteractor: PostRepositoryDelegate {
	
	func didPostsLoadedFailure(error: Error) {
		guard let delegate = delegate else {
			print ("PostInteractor.didPostsLoadedFailure - There are not delegate assigned")
			return
		}
		delegate.onPostsLoadedFailure(error: error)
	}
	
	func didPostsLoadedSuccess(posts: [Post]) {
		guard let delegate = delegate else {
			print ("PostInteractor.didPostsLoadedSuccess - There are not delegate assigned")
			return
		}
		delegate.onPostsLoadedSuccess(posts: posts)
	}
	
}
