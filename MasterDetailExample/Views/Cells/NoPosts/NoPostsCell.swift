//
//  NoPostsCell.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

class NoPostsCell: UITableViewCell {
    
    @IBOutlet weak var messageOutlet: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(_ viewModel: NoPostsCellViewModel) {
        messageOutlet.text = viewModel.message
    }

    
}
