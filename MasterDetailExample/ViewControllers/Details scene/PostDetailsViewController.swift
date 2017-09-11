//
//  PostDetailsViewController.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleOutlet: SkyFloatingLabelTextField!
    @IBOutlet weak var bodyOutlet: UILabel!
    

    fileprivate var viewModel: PostDetailsViewModel!
    
    convenience init(viewModel: PostDetailsViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModelEvents()
        updateUI()
    }

    fileprivate func setupUI() {
        
        titleOutlet.placeholder = "title".localized
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = []
    }
    
    fileprivate func setupViewModelEvents() {
        
    }
    
    fileprivate func updateUI() {
        
        titleOutlet.text = viewModel.title
        bodyOutlet.text = viewModel.body
        title = viewModel.viewTitle
    }
}

extension PostDetailsViewController: StylableViewController {
    
    var navigationBarTintColor: UIColor? {
        return Config.colors.lightBlue
    }
}
