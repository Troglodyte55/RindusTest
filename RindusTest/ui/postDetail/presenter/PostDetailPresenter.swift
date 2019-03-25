//
//  PostDetailPresenter.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 20/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

// MARK: - Post Detail Action
protocol PostDetailPresenterAction {
    
    init (with post: PostVO)
    
    var ui: PostDetailPresenterDelegate? { get set }
    
    func viewDidLoad()
    
    func getComments(from post: PostVO)
    
}

// MARK: - Post Detail Delegate
protocol PostDetailPresenterDelegate: UIProtocol {
    
    func setPostInfo(_ post: PostVO)
    
    func loadComments(_ comments: [CommentVO])
    
    func renderComments()
    
}

// MARK: - Post Detail Action
class PostDetailPresenter: PostDetailPresenterAction {
    
    weak var ui: PostDetailPresenterDelegate?
    
    private lazy var interactor: CommentInteractorAction = {
        return CommentInteractor(with: self)
    }()
    
    var post: PostVO
    
    required init(with post: PostVO) {
        self.post = post
    }
    
    func viewDidLoad() {
        guard let ui = ui else {
            return
        }
        ui.setPostInfo(post)
        ui.showLoader()
        getComments(from: post)
    }
    
    func getComments(from post: PostVO) {
        interactor.getComments(by: Post(from: post))
    }
    
}

extension PostDetailPresenter: CommentInteractorDelegate {
    
    func onCommentsLoadedFailure(error: Error) {
        guard let ui = ui else {
            print("PostDetailPresenter.onCommentsLoadedFailure - There are not ui assigned")
            return
        }
        ui.hideLoader()
        ui.showConnectionError()
    }
    
    func onCommentsLoadedSuccess(comments: [Comment]) {
        guard let ui = ui else {
            print("PostDetailPresenter.onCommentsLoadedSuccess - There are not ui assigned")
            return
        }
        let validComments = getCommentsVO(from: comments)
        ui.loadComments(validComments)
        ui.hideLoader()
        if validComments.count == 0 {
            ui.showConnectionError()
        } else {
            ui.renderComments()
        }
        
    }
    
    private func getCommentsVO(from comments: [Comment]) -> [CommentVO] {
        return comments
            .filter { comment in
                return comment.body != nil
            }
            .map { (comment: Comment) in
                return CommentVO(from: comment)
        }
    }
    
}
