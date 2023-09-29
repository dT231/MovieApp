//
//  FadeAnimator.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import MAUIKit
import UIKit

final class FadeAnimator: NSObject {
    private let animationDuration: Double = Constants.AnimationDurations.defaultApple
}

extension FadeAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let incomingView = transitionContext.view(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        incomingView.alpha = 0
        containerView.addSubview(incomingView)

        UIView.animate(withDuration: animationDuration, animations: {
            incomingView.alpha = 1.0
        }, completion: { success in
            transitionContext.completeTransition(success)
        })
    }
}
