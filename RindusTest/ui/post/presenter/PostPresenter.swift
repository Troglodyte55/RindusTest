//
//  PostPresenter.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

protocol PostPresenterAction {
	
	func viewDidLoad()
	
	func getPosts()
	
}

protocol PostPresenterDelegate: class {
	
	func hideLoader()
	
	func showLoader()
	
	func showConexionError()
	
	func loadPosts(_ posts: [PostVO])
	
}

class PostPresenter: PostPresenterAction {
	
	var interactor: PostInteractorAction!
	
	var ui: PostPresenterDelegate?
	
	init() {
		interactor = PostInteractor()
	}
	
	func viewDidLoad() {
		guard let ui = ui else {
			return
		}
		ui.showLoader()
	}
	
	func getPosts() {
		interactor.getPosts()
	}
	
}

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
		ui.hideLoader()
	}
	
}
