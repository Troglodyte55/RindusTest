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
	
	func didPostsLoaded()
	
}

class PostPresenter: PostPresenterAction {
	
	var interactor: PostInteractorAction!
	
	init() {
		interactor = PostInteractor()
	}
	
	func viewDidLoad() {
		
	}
	
	func getPosts() {
		interactor.getPosts()
	}
	
}
