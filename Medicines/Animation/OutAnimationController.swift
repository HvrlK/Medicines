//
//  OutAnimationController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/24/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class OutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(
                withDuration: duration,
                animations: {
                    fromView.alpha = 0
            },
                completion: { finished in
                    transitionContext.completeTransition(finished)
            })
        }
    }
    
}

