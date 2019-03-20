//
//  CommentRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 20/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation
import Alamofire

private let commentsUrl = ""

protocol CommentRepositoryAction {
    
    var delegate: CommentRepositoryDelegate? { get set }
    
    init (with delegate: CommentRepositoryDelegate)
    
    func getComments(from post: Post)
    
}

protocol CommentRepositoryDelegate: class {
    
    func didCommentsLoadedFailure(error: Error)
    
    func didCommentsLoadedSuccess(comments: [Comment])
    
}

class CommentRepository: CommentRepositoryAction {
    
    private var comments: [Comment]?
    
    weak var delegate: CommentRepositoryDelegate?
    
    required init(with delegate: CommentRepositoryDelegate) {
        self.delegate = delegate
    }
    
    func getComments(from post: Post) {
        AF.request(commentsUrl).responseDecodable(decoder: JSONDecoder()) { [weak self] (response: DataResponse<[CommentDTO]>) in
            guard let self = self else {
                return
            }
            switch response.result {
            case .success(let value):
                self.comments = value.map { (commentDTO: CommentDTO) -> Comment in
                    return Comment(from: commentDTO)
                }
                self.commentsLoaded(error: nil)
            case .failure(let error):
                self.commentsLoaded(error: error)
                
            }
        }
    }
    
    private func commentsLoaded(error: Error?) {
        guard let delegate = delegate else {
            print ("CommentRepository - There are not delegate designated")
            return
        }
        if let error = error {
            delegate.didCommentsLoadedFailure(error: error)
            return
        }
        if let comments = comments {
            delegate.didCommentsLoadedSuccess(comments: comments)
        }
    }
    
}
