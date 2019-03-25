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
    
    init(with presenter: PostDetailPresenterAction)
    
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
    
    required init(with presenter: PostDetailPresenterAction) {
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
        registerCells()
        loadStyle()
        presenter.viewDidLoad()
    }
    
    override func loadStyle() {
        super.loadStyle()
        tableView.isHidden = true
        tableView.allowsSelection = false
        emptyListLabel.font =  .systemFont(ofSize: 25, weight: .medium)
        emptyListLabel.numberOfLines = 0
        emptyListLabel.textAlignment = .center
        emptyListLabel.textColor = .lightGray
        emptyListLabel.isHidden = true
        emptyListLabel.text = "There aren't comments."
        datePostLabel.font = .systemFont(ofSize: 16, weight: .bold)
        datePostLabel.textColor = .darkGray
    }

}

extension PostDetailViewController: PostDetailPresenterDelegate {
    
    func setPostInfo(_ post: PostVO) {
        title = post.title
        datePostLabel.text = post.date
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
	
    /// Private functions
    
	private func registerCells() {
		let commentCell = UINib(nibName: "PostCommentTableViewCell", bundle: nil)
		tableView.register(commentCell, forCellReuseIdentifier: PostCommentTableViewCell.identifier)
	}
	
	private func getComment(by indexPath: IndexPath) -> CommentVO? {
		guard let comments = comments else {
			return nil
		}
		return comments[indexPath.row]
	}
	
    /// Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    /// Rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = comments else {
            return 0
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
