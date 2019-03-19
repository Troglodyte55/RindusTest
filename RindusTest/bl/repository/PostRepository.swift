//
//  PostRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation
import Alamofire

private let postsUrl = "https://raw.githubusercontent.com/Troglodyte55/RindusTest/master/RindusTest/App/res/JSONExample/Post.json"

protocol PostRepositoryAction {
	
	var delegate: PostRepositoryDelegate? { get set }
	
	func getPosts()
	
}

protocol PostRepositoryDelegate: class {

	func didPostsLoadedSuccess(posts: [Post])
	
	func didPostsLoadedFailure(error: Error)
	
}

class PostRepository: PostRepositoryAction {
	
	private var posts: [Post]?
	
	weak var delegate: PostRepositoryDelegate?
	
	func getPosts() {
		
		AF.request(postsUrl).responseDecodable (decoder: JSONDecoder()) { (response: DataResponse<[PostDTO]>) in
			switch response.result {
			case .success(let value):
				self.posts = value.map {
					Post(from: $0)
				}
				self.postsLoaded(error: nil)
				
			case .failure(let error):
				self.postsLoaded(error: error)
			}
		}
	}
	
	private func postsLoaded(error: Error?) {
		guard let delegate = delegate else {
			print ("PostRepository - There are not delegate designated")
			return
		}
		if let error = error {
			delegate.didPostsLoadedFailure(error: error)
			return
		}
		if let posts = posts {
			delegate.didPostsLoadedSuccess(posts: posts)
		}
	}
	
}
