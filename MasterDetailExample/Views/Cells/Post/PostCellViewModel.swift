//
//  PostCellViewModel.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 05.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit


class PostCellViewModel {
    
    fileprivate let post: Post
    
    init(with post: Post) {
        self.post = post    }
    
    var didUpdate: ((PostCellViewModel) -> Void)?
    var didSelect: ((Post) -> Void)?
    
    var title: String { return post.title }
    var body: String { return post.body }
}

extension PostCellViewModel: CellRepresentable {
    
    static func registerCell(_ tableView: UITableView) {
        let cellName = String(describing: PostCell.self)
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    
    func dequeCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cellName = String(describing: PostCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! PostCell
        
        cell.setup(self)
        return cell
    }
    
    func cellSelected() {
        self.didSelect?(self.post)
    }
}
