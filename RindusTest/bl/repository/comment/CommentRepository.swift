//
//  CommentRepository.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 20/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import Foundation
import Alamofire

private let commentsUrl = "https://raw.githubusercontent.com/Troglodyte55/RindusTest/master/RindusTest/res/json/Comment.json"

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
    
    /// Time interval difference: 5 min.
    private static let timeDifferenceBetweenRequests: Double = 300
    
    private var lastRequestTimeInterval: TimeInterval?
    
    private var comments: [Comment]?
    
    weak var delegate: CommentRepositoryDelegate?
    
    required init(with delegate: CommentRepositoryDelegate) {
        self.delegate = delegate
    }
    
    func getComments(from post: Post) {
        if shouldSendRequest() {
            requestComments()
        } else {
            commentsLoaded(error: nil)
        }
    }
    
    private func shouldSendRequest() -> Bool {
        guard let lastRequestTimeInterval = lastRequestTimeInterval,
        let _ = comments else {
            return true
        }
        
        let currentTimestamp = Date().timeIntervalSince1970
        if currentTimestamp - lastRequestTimeInterval >= CommentRepository.timeDifferenceBetweenRequests {
            return true
        }
        return false
    }
    
    private func requestComments() {
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
            print ("CommentRepository - There are not delegate assigned")
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
