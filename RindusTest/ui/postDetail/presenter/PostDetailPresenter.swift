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
    
    func setTitle(_ title: String)
    
    func loadComments(_ comments: [CommentVO])
    
    func renderComments()
    
}

// MARK: - Post Detail Action
class PostDetailPresenter: PostDetailPresenterAction {
    
    weak var ui: PostDetailPresenterDelegate?
    
    var post: PostVO
    
    required init(with post: PostVO) {
        self.post = post
    }
    
    func viewDidLoad() {
        guard let ui = ui else {
            return
        }
        if let title = post.title {
            ui.setTitle(title)
        }
        ui.showLoader()
        getComments(from: post)
    }
    
    func getComments(from post: PostVO) {
        print ("PostPresenter.getComments - There are not implemented")
    }
    
}
