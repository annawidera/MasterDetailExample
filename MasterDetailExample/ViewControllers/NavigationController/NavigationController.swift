//
//  NavigationController.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit

protocol StylableViewController: class {
    var navigationBarTintColor: UIColor? { get }
}


class NavigationController: UINavigationController {

    struct DefaultColors {
        let navigationBarBackground: UIColor = .white
        let navigationBarTint: UIColor = .darkGray
    }
    fileprivate let defaultColors = DefaultColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.style(viewController: viewController)
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if let destinationVC = self.viewControllers.dropLast().last {
            self.style(viewController: destinationVC)
        }
        return super.popViewController(animated: animated)
    }
    
    
    
    fileprivate func style(viewController vc: UIViewController) {

        let navBarTint = (vc as? StylableViewController)?.navigationBarTintColor ?? defaultColors.navigationBarTint
        self.navigationBar.barTintColor = navBarTint
    }

}
