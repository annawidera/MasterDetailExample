//
//  NoPostsCellViewModel.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

class NoPostsCellViewModel {
    
    var message: String {
        return "There are no posts.".localized
    }
}


extension NoPostsCellViewModel: CellRepresentable {
    
    static func registerCell(_ tableView: UITableView) {
        let cellName = String(describing: NoPostsCell.self)
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    
    func dequeCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cellName = String(describing: NoPostsCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! NoPostsCell
        
        cell.setup(self)
        return cell
    }
    
    func cellSelected() {
        // do nothing
    }
}
