//
//  DismissAnimator.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import UIKit
import MAUIKit

final class DismissAnimator: NSObject {
    private let animationDuration: Double = Constants.AnimationDurations.defaultApple
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)

        UIView.transition(with: containerView, duration: animationDuration, options: [.curveEaseInOut]) {
            snapshot.frame = CGRect(
                x: snapshot.bounds.origin.x,
                y: snapshot.bounds.size.height,
                width: snapshot.bounds.size.width,
                height: snapshot.bounds.size.height
            )
        } completion: {
            snapshot.removeFromSuperview()
            transitionContext.completeTransition($0)
        }

        var animator: UIViewPropertyAnimator?
        if fromVC.hidesBottomBarWhenPushed, !toVC.hidesBottomBarWhenPushed, let tab = fromVC.tabBarController?.tabBar {
            animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
            tab.layer.removeAllAnimations()
            tab.frame.origin.y += tab.bounds.height
            animator?.addAnimations {
                tab.frame.origin.y -= tab.bounds.height
            }
        }

        animator?.startAnimation()
    }
}
