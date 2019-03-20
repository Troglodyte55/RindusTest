//
//  PostWireframe.swift
//  RindusTest
//
//  Created by Alberto Luque Fernández on 3/13/19.
//  Copyright © 2019 aluque. All rights reserved.
//

import UIKit

class PostWireframe {
	
	static func createModule() -> PostViewController {
		let presenter = PostPresenter()
		let view = PostViewController(with: presenter)
        presenter.ui = view
		return view
	}
	
    static func createModuleWithNavigation() -> UINavigationController {
        let view = createModule()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [view]
        return navigationController
    }
    
    static func navigate(toDetailWith post: PostVO, from navigationController: UINavigationController) {
        let view = PostDetailWireframe.createModule(with: post)
        navigationController.pushViewController(view, animated: true)
    }
    
}
