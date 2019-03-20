//
//  PostRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit
import Alamofire

private let postsUrl = "https://raw.githubusercontent.com/Troglodyte55/RindusTest/master/RindusTest/res/json/Post.json"

protocol PostRepositoryAction {
	
    var delegate: PostRepositoryDelegate? { get set }
    
    init (with delegate: PostRepositoryDelegate)
	
	func getPosts()
	
}

protocol PostRepositoryDelegate: class {

	func didPostsLoadedSuccess(posts: [Post])
	
	func didPostsLoadedFailure(error: Error)
	
}

class PostRepository: PostRepositoryAction {
	
	private var posts: [Post]?
	
	weak var delegate: PostRepositoryDelegate?
	
    required init(with delegate: PostRepositoryDelegate) {
        self.delegate = delegate
    }
    
    
	func getPosts() {
		AF.request(postsUrl).responseDecodable(decoder: JSONDecoder()) { [weak self] (response: DataResponse<[PostDTO]>) in
            guard let self = self else {
                return
            }
			switch response.result {
			case .success(let value):
                self.posts = value.map { (postDTO: PostDTO) -> Post in
					Post(from: postDTO)
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
