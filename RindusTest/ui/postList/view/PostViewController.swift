//
//  PostViewController.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

protocol PostViewControllerProtocol: class {

	var posts: [PostVO]? { get set }
	
}

// MARK: Post View Protocol
class PostViewController: BaseViewController, PostViewControllerProtocol {
    
    // Properties
    var posts: [PostVO]?

	var presenter: PostPresenterAction
	
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyListLabel: UILabel!
    
    // Implementation
	required init(with presenter: PostPresenterAction) {
		self.presenter = presenter
		super.init(nibName: "PostViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStyle()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.viewDidLoad()
    }
    
    override func loadStyle() {
        super.loadStyle()
        title = "MCU"
        tableView.isHidden = true
        emptyListLabel.font =  UIFont.systemFont(ofSize: 25, weight: .thin)
        emptyListLabel.numberOfLines = 0
        emptyListLabel.textAlignment = .center
        emptyListLabel.textColor = UIColor.darkGray
        emptyListLabel.isHidden = true
        emptyListLabel.text = "An connection error was ocurred. Try it later"
    }
	
}

// MARK: - Presenter Delegate
extension PostViewController: PostPresenterDelegate {
	
	func hideLoader() {
		activityLoader?.stopAnimating()
	}
	
	func showLoader() {
		activityLoader?.startAnimating()
	}
	
	func showConnectionError() {
        activityLoader?.isHidden = true
        emptyListLabel.isHidden = false
        tableView.isHidden = true
	}
	
	func loadPosts(_ posts: [PostVO]) {
		self.posts = posts
	}
    
    func renderPosts() {
        activityLoader?.isHidden = true
        emptyListLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }

}

// MARK: - Table View Handlers
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Private functions
    
    private func getPost(by indexPath: IndexPath) -> PostVO? {
        guard let posts = posts else {
            return nil
        }
        return posts[indexPath.row]
    }
    
    private func setup(_ cell: UITableViewCell, post: PostVO) {
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.date
    }
    
    /// Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    /// Rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = posts else {
            return 0
        }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        guard let post = getPost(by: indexPath) else {
            return cell
        }
        setup(cell, post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = getPost(by: indexPath),
            let navigationController = self.navigationController else {
                return
        }
        presenter.showDetail(of: post, from: navigationController)
    }
}
