//
//  PostRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation
import Alamofire

private let postsUrl = "https://github.com/Troglodyte55/RindusTest/blob/master/RindusTest/App/res/JSONExample/Post.json"

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
			switch response.result {
			case .success(let value):
				print(value)
				break
			case .failure(let error):
				print(error.localizedDescription)
				break
			}
		}
	}
	
}
