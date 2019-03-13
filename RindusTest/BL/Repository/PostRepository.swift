//
//  PostRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation
import Alamofire

private let postsUrl = "https://my-json-server.typicode.com/typicode/demo/posts"

protocol PostRepositoryAction {
	
	var delegate: PostRepositoryDelegate? { get set }
	
	func getPosts()
	
}

protocol PostRepositoryDelegate: class {
	
	func didPostsLoaded(posts: [Post])
	
}

class PostRepository: PostRepositoryAction {
	
	private var posts: [Post]?
	
	weak var delegate: PostRepositoryDelegate?
	
	func getPosts() {
		AF.request(postsUrl).responseDecodable (decoder: JSONDecoder()) { (response: DataResponse<PostDTO>) in
			if let error = response.error {
				print(error.localizedDescription)
				return
			}
			
			let post = response.result
			
		}
	}
	
}
