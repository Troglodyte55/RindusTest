//
//  CommentInteractor.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 25/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation

// MARK: - Comment Interactor Action
protocol CommentInteractorAction {
    
    var delegate: CommentInteractorDelegate? { get set }
    
    init(with delegate: CommentInteractorDelegate)
    
    func getComments(by post: Post)
    
}

// MARK: - Comment Interactor Delegate
protocol CommentInteractorDelegate: class {
    
    func onCommentsLoadedFailure(error: Error)
    
    func onCommentsLoadedSuccess(comments: [Comment])
    
}

// MARK: - Comment Interactor Implementation
class CommentInteractor: CommentInteractorAction {
    
    private var currentPost: Post?
    
    var delegate: CommentInteractorDelegate?
    
    lazy var repository: CommentRepositoryAction = {
        return CommentRepository(with: self)
    }()
    
    required init(with delegate: CommentInteractorDelegate) {
        self.delegate = delegate
    }
    
    func getComments(by post: Post) {
        currentPost = post
        repository.getComments(from: post)
    }
    
}


// MARK - Comment Repository Delegate implementation
extension CommentInteractor: CommentRepositoryDelegate {
    
    func didCommentsLoadedFailure(error: Error) {
        guard let delegate = delegate else {
            print("CommentInteractor.didCommentsLoadedFailure - There are not delegate assigned")
            return
        }
        delegate.onCommentsLoadedFailure(error: error)
    }
    
    func didCommentsLoadedSuccess(comments: [Comment]) {
        guard let delegate = delegate else {
            print("CommentInteractor.didCommentsLoadedSuccess - There are not delegate assigned")
            return
        }
        guard let currentPost = currentPost else {
            return
        }
        let commentsFromCurrentPost = getComments(from: comments, by: currentPost)
        delegate.onCommentsLoadedSuccess(comments: commentsFromCurrentPost)
    }
    
    private func getComments(from comments: [Comment], by post: Post) -> [Comment] {
        return comments.filter { comment in
            return comment.postId == post.id
        }
    }
    
}
