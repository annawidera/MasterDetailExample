//
//  CellRepresentable.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    static func registerCell(_ tableView: UITableView)
    func dequeCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func cellSelected()
}
