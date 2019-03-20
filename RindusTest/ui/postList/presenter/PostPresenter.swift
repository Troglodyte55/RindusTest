//
//  PostPresenter.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

// MARK: - Presenter Action
protocol PostPresenterAction {
	
    var ui: PostPresenterDelegate? { get set }
    
	func viewDidLoad()
	
	func getPosts()
    
    func showDetail(of post: PostVO, from navigationController: UINavigationController)
	
}

// MARK: - Presenter Delegate
protocol PostPresenterDelegate: UIProtocol {
	
	func loadPosts(_ posts: [PostVO])
    
    func renderPosts()
	
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
	
    func showDetail(of post: PostVO, from navigationController: UINavigationController) {
        PostWireframe.navigate(toDetailWith: post, from: navigationController)
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
        ui.showConnectionError()
	}
	
	func onPostsLoaded(posts: [Post]) {
		guard let ui = ui else {
			print ("PostPresenter.onPostsLoaded - There are not ui designated")
			return
		}
        let postsVO = getPostsVO(from: posts)
        ui.loadPosts(postsVO)
		ui.hideLoader()
        ui.renderPosts()
	}
    
    private func getPostsVO(from posts: [Post]) -> [PostVO] {
        return posts.map { (post) -> PostVO in
            return PostVO(with: post)
        }
    }
	
}
