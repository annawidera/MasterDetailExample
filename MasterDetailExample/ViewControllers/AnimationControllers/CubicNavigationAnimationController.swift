//
//  CubicNavigationAnimationController.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 11.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit


class CubicNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.viewController(forKey: .from)?.view,
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        let toView = toVC.view!
        let container = transitionContext.containerView
        let finalFrameForVC = transitionContext.finalFrame(for: toVC)
        
        let offScreenRightFrame = CGRect(x: container.frame.width, y: container.frame.origin.y, width: container.frame.width, height: container.frame.height)
        let offScreenLeftFrame = CGRect(x: -container.frame.width, y: container.frame.origin.y, width: container.frame.width, height: container.frame.height)
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        toView.frame = reverse ? offScreenLeftFrame : offScreenRightFrame
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            fromView.frame = self.reverse ? offScreenRightFrame : offScreenLeftFrame
            toView.frame = finalFrameForVC
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }

}
