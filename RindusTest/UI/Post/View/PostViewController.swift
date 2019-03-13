//
//  PostViewController.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

protocol PostViewControllerProtocol: NSObjectProtocol {
	
	var presenter: PostPresenterAction { get }
	
}

class PostViewController: UIViewController {

	var presenter: PostPresenterAction
	
	required init(with presenter: PostPresenterAction) {
		self.presenter = presenter
		super.init(nibName: "PostViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.presenter.getPosts()
    }

}

extension PostViewController: PostPresenterDelegate {
	
	func didPostsLoaded() {
		
	}

}
