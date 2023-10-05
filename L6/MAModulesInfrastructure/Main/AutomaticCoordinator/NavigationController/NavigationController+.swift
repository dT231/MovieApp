//
//  NavigationController.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 05.10.2023.
//

import UIKit

extension UINavigationController {
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        popToViewController(viewController, animated: animated)
        runCompletionIfNeeded(animated: animated, completion: completion)
    }
}

private extension UINavigationController {
    func runCompletionIfNeeded(animated: Bool, completion: (() -> Void)?) {
        guard let coordinator = transitionCoordinator, animated else {
            completion?()
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in
            completion?()
        }
    }
}
