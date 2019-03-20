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

class PostViewController: BaseViewController, PostViewControllerProtocol {
    
    // Properties
    var posts: [PostVO]?

	var presenter: PostPresenterAction
	
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
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
	
}

extension PostViewController: PostPresenterDelegate {
	
	func hideLoader() {
		activityLoader?.stopAnimating()
	}
	
	func showLoader() {
		activityLoader?.startAnimating()
	}
	
	func showConexionError() {
		
	}
	
	func loadPosts(_ posts: [PostVO]) {
		self.posts = posts
        tableView.reloadData()
	}

}

// MARK: - Table View Handlers
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func getPost(by indexPath: IndexPath) -> PostVO? {
        guard let posts = posts else {
            return nil
        }
        return posts[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        cell.textLabel?.text = "\(post.id)"
        cell.detailTextLabel?.text = post.title
        return cell
    }
    
}
