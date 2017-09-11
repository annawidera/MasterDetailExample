//
//  PostCell.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 05.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    func setup(_ viewModel: PostCellViewModel) {
        
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.body
        
        viewModel.didUpdate = self.setup
    }
    
}
