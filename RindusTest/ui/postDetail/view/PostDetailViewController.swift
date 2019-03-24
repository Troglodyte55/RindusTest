//
//  PostDetailViewController.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 20/03/2019.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

protocol PostDetailViewProtocol: class {
    
    var comments: [CommentVO]? { get set }
    
}

// MARK: - PostDetail Protocol
class PostDetailViewController: BaseViewController, PostDetailViewProtocol {

    /// Properties
    var comments: [CommentVO]?
    
    var presenter: PostDetailPresenterAction
    
    /// Outlets
    @IBOutlet weak var datePostLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyListLabel: UILabel!
    
    /// Implementation
    
    init(with presenter: PostDetailPresenterAction) {
        self.presenter = presenter
        super.init(nibName: "PostDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadStyle()
        presenter.viewDidLoad()
    }
    
    override func loadStyle() {
        tableView.isHidden = true
        emptyListLabel.font =  UIFont.systemFont(ofSize: 25, weight: .thin)
        emptyListLabel.numberOfLines = 0
        emptyListLabel.textAlignment = .center
        emptyListLabel.textColor = UIColor.darkGray
        emptyListLabel.isHidden = true
        emptyListLabel.text = "There aren't comments."
    }

}

extension PostDetailViewController: PostDetailPresenterDelegate {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func loadComments(_ comments: [CommentVO]) {
        self.comments = comments
    }
    
    func renderComments() {
        emptyListLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func showLoader() {
        emptyListLabel.isHidden = true
        tableView.isHidden = true
        activityLoader?.startAnimating()
    }
    
    func hideLoader() {
        emptyListLabel.isHidden = true
        tableView.isHidden = true
        activityLoader?.stopAnimating()
    }
    
    func showConnectionError() {
        tableView.isHidden = true
        emptyListLabel.isHidden = false
    }
    
}

// MARK: - Table View Handlers
extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
	
	private func regiterCells() {
		let commentCell = UINib(nibName: "PostCommentTableViewCell", bundle: nil)
		tableView.register(commentCell, forCellReuseIdentifier: PostCommentTableViewCell.identifier)
	}
	
	private func getComment(by indexPath: IndexPath) -> CommentVO? {
		guard let comments = comments else {
			return nil
		}
		return comments[indexPath.row]
	}
	
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = comments else {
            return 0
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let comment = getComment(by: indexPath) else {
			return UITableViewCell()
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTableViewCell.identifier, for: indexPath) as! PostCommentTableViewCell
		cell.loadCell(with: comment)
        return cell
    }
    
}
