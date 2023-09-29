//
//  PresentAnimator.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import MAUIKit
import UIKit

final class PresentAnimator: NSObject {
    private let animationDuration: Double = Constants.AnimationDurations.defaultApple
}

extension PresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let incomingController = transitionContext.viewController(forKey: .to),
            let incomingView = incomingController.view
        else {
            return
        }
        let container = transitionContext.containerView

        container.addSubview(incomingView)
        incomingView.frame.origin = CGPoint(x: 0, y: incomingView.frame.height)

        UIView.transition(with: incomingView, duration: animationDuration, options: [.curveEaseOut], animations: {
            incomingView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: {
            transitionContext.completeTransition($0)
        })

        var animator: UIViewPropertyAnimator?

        if incomingController.hidesBottomBarWhenPushed, let tab = incomingController.tabBarController?.tabBar {
            animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
            tab.layer.removeAllAnimations()
            tab.frame.origin.x = 0
            animator?.addAnimations {
                tab.frame.origin.y += tab.bounds.height
            }
        }

        animator?.startAnimation()
    }
}

