//
//  Navigation.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

class Navigation: NSObject, UINavigationControllerDelegate {
    
    fileprivate let navigationController: UINavigationController
    fileprivate let application: Application
    fileprivate let cubicNavigationAnimationController = CubicNavigationAnimationController()
    
    init(window: UIWindow,
         navigationController: UINavigationController,
         application: Application) {
        self.application = application
        self.navigationController = navigationController
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        super.init()
        self.navigationController.delegate = self
    }
    
    func start() {
        self.showPostsList()
    }
    
    fileprivate func showPostsList() {
        
        let viewModel = PostsListViewModel(provider: application.postsProvider)
        viewModel.didSelectPost = { [weak self] post in
            self?.showDetails(for: post)
        }
        
        viewModel.didAddPressed = { [weak self] in
            self?.showAddPost()
        }
        
        let viewController = PostsListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
        
    }
    
    
    fileprivate func showDetails(for post: Post) {
        
        let viewModel = PostDetailsViewModel(post: post)
        let viewController = PostDetailsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    
    fileprivate func showAddPost() {
        
        let viewModel = AddPostViewModel(provider: application.postsProvider, postFieldsValidator: application.postFieldsValidator)
        let viewController = AddPostViewController(viewModel: viewModel)
        
        viewModel.didSavePost = { [weak self] in
            let _ = self?.navigationController.popViewController(animated: true)
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
    }

    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        cubicNavigationAnimationController.reverse = operation == .pop
        return cubicNavigationAnimationController
    }
}
