//
//  PostPresenter.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

// MARK: - Presenter Action
protocol PostPresenterAction {
	
    var ui: PostPresenterDelegate? { get set }
    
	func viewDidLoad()
	
	func getPosts()
	
}

// MARK: - Presenter Delegate
protocol PostPresenterDelegate: class {
	
	func hideLoader()
	
	func showLoader()
	
	func showConexionError()
	
	func loadPosts(_ posts: [PostVO])
	
}

// MARK: - Presenter Implementation
class PostPresenter: PostPresenterAction {

    weak var ui: PostPresenterDelegate?
    
    lazy var interactor: PostInteractorAction = {
        return PostInteractor(with: self)
    }()
	
	func viewDidLoad() {
		guard let ui = ui else {
			return
		}
		ui.showLoader()
        getPosts()
	}
	
	func getPosts() {
		interactor.getPosts()
	}
	
}

// MARK: Post Interactor Delegate
extension PostPresenter: PostInteractorDelegate {
	
	func onPostsFailure(error: Error) {
		guard let ui = ui else {
			print ("PostPresenter.onPostsFailure - There are not ui designated")
			return
		}
		ui.hideLoader()
	}
	
	func onPostsLoaded(posts: [Post]) {
		guard let ui = ui else {
			print ("PostPresenter.onPostsLoaded - There are not ui designated")
			return
		}
        let postsVO = posts.map { (post) -> PostVO in
            return PostVO(with: post)
        }
        ui.loadPosts(postsVO)
		ui.hideLoader()
	}
	
}
