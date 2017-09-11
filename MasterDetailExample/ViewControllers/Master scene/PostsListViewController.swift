//
//  PostsListViewController.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

class PostsListViewController: UITableViewController/*, UINavigationControllerDelegate*/ {
    
    fileprivate var viewModel: PostsListViewModel!
//    fileprivate let cubicNavigationAnimationController = CubicNavigationAnimationController()
    
    required convenience init(viewModel: PostsListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isUserInteractionEnabled = true

        self.title = viewModel.title
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,
                                         target: self,
                                         action: #selector(PostsListViewController.addNewPost))
        self.navigationItem.rightBarButtonItem = plusButton
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self,
                                 action: #selector(PostsListViewController.reloadData),
                                 for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        
        self.registerViewModelCells()
        self.registerViewModelEvents()
        
//        self.navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadData()
        super.viewWillAppear(animated)
    }
    
    
    fileprivate func registerViewModelCells() {
        self.viewModel.postsViewModelTypes.forEach({ $0.registerCell(self.tableView) })
    }
    
    
    fileprivate func registerViewModelEvents() {
        
        self.viewModel.onUpdate = { [weak self] _ in
            self?.onViewModelUpdate()
        }
        
        self.viewModel.onError = { [weak self] message in
            self?.onViewModelError(message)
        }
    }
    
    
    
    fileprivate func onViewModelUpdate() {
        
        self.hideRefreshingIndicator()
        self.title = viewModel.title
        self.navigationItem.rightBarButtonItem?.isEnabled = !self.viewModel.isUpdating
        self.tableView.reloadData()
    }
    
    
    fileprivate func onViewModelError(_ message: String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true) { [weak self] in
            self?.hideRefreshingIndicator()
        }
    }
    
    @objc fileprivate func reloadData() {
        self.viewModel.reloadData()
    }
    
    @objc fileprivate func addNewPost() {
        self.viewModel.addNewCar()
    }
    
    fileprivate func hideRefreshingIndicator() {
        guard let refreshControl = self.refreshControl else { return }
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
//    // MARK: - UINavigationControllerDelegate
//    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        cubicNavigationAnimationController.reverse = operation == .pop
//        return cubicNavigationAnimationController
//    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.postsViewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.postsViewModels[indexPath.item].dequeCell(tableView, at: indexPath)
    }
    
    // MARK: - UITableViewDelegate
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.postsViewModels[indexPath.item].cellSelected()
    }
}

extension PostsListViewController: StylableViewController {
    
//    var navigationBarBackgroundColor: UIColor? {
//        return UIColor.red
//        return Config.colors.lightPurple
//    }
    
    var navigationBarTintColor: UIColor? {
        return Config.colors.gray
    }
    
}
