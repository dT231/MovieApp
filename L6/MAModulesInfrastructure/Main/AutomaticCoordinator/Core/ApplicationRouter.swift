//
//  ApplicationRouter.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation
import UIKit
import MAUIKit
import MAFoundation

/// Сущность реализующая маршрутизацию
open class ApplicationRouter: NSObject {
    /// Тип эвента передаваемого в слушателя
    public enum RouterEvent {
        case uikit
        case userInitiative
    }

    public enum NavigationError: Error {
        case numberOfDismissCallsExceeds
        case cannotFindLastPresented
        case invalidNumberOfDismissingModules
    }

    private weak var rootController: SystemNavigationController?
    private var popTransition: Transition?
    private var pushTransition: Transition?
    private let windowHierarchyHelper: WindowHierarchyHelping
    private var listeners: [WeakReference<LifeCycleListener>] = []

    public init(
        rootController: SystemNavigationController?,
        windowHierarchyHelper: WindowHierarchyHelping = WindowHierarchyHelper(windowHelper: UIApplication.shared)
    ) {
        self.rootController = rootController
        self.windowHierarchyHelper = windowHierarchyHelper

        super.init()

        self.rootController?.delegate = self
        self.rootController?.popToRootHandler = { [weak self] in
            guard let self = self else {
                return
            }

            self.lastListener?.toRootNofity(in: self)
        }
    }
}

extension ApplicationRouter: Routable {
    public func popModules(numberOfModules: Int, transition: Transition?, animated: Bool, completion: (() -> Void)?) {
        guard let viewControllers = rootController?.viewControllers else {
            return
        }

        let targetViewControllerIndex = viewControllers.count - numberOfModules - 1

        guard (0 ..< viewControllers.count).contains(targetViewControllerIndex) else {
            return
        }

        let popToViewController = viewControllers[targetViewControllerIndex]

        popTransition = transition
        rootController?.popToViewController(popToViewController, animated: animated) { [weak self] in
            for _ in 0 ..< numberOfModules {
                self?.lastListener?.decrement()
            }
        }
    }
    
    public func dismissToRoot(animated: Bool, completion: (() -> Void)?) {
        guard let lastPresented = lastPresented else {
            return
        }

        dismissToRootPresenting(for: lastPresented, animated: animated, completion: completion)
    }
    
    public func dismissPresentedModules(numberOfModulesToDismiss: UInt, animated: Bool, completion: (() -> Void)?) throws {
        guard let lastPresented = lastPresented else {
            throw NavigationError.cannotFindLastPresented
        }

        guard numberOfModulesToDismiss > .zero else {
            throw NavigationError.invalidNumberOfDismissingModules
        }

        try dismiss(viewController: lastPresented, animated: animated, count: numberOfModulesToDismiss) {
            for _ in 0 ..< numberOfModulesToDismiss {
                let lastListener = self.lastListener

                if self.lastPresentedHaveNavigation {
                    lastListener?.dismissNotify(event: .userInitiative)
                } else {
                    lastListener?.decrement()
                }
            }

            completion?()
        }
    }
    
    public func subscribe(_ listener: LifeCycleListener) {
        listeners.append(WeakReference(listener))
    }
    
    public func isLast(module: Presentable) -> Bool {
        return rootController?.viewControllers.last === module.toPresent
    }
    
    public func isVisible(_ module: Presentable) -> Bool {
        guard module.toPresent.view.window != nil, module.toPresent.isViewLoaded else {
            return false
        }

        return rootController?.topViewController === module.toPresent && rootController?.presentedViewController == nil
    }
    
    public var isModallyPresented: Bool {
        rootController?.presentingViewController == nil
    }
    
    private func dismiss(viewController: UIViewController, animated: Bool, count: UInt, completion: (() -> Void)?) throws {
        guard count != .zero else {
            viewController.dismiss(animated: animated, completion: completion)

            return
        }

        guard let presentingViewController = viewController.presentingViewController else {
            throw NavigationError.numberOfDismissCallsExceeds
        }

        try dismiss(viewController: presentingViewController, animated: animated, count: count - 1, completion: completion)
    }
    
    private func dismissToRootPresenting(for viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let presentingViewController = viewController.presentingViewController {
            dismissToRootPresenting(for: presentingViewController, animated: animated, completion: completion)
            return
        }

        let numberOfPresented = numberOfPresentedViewControllers

        viewController.dismiss(animated: animated) {
            for _ in 0 ..< numberOfPresented {
                let lastListener = self.lastListener

                if self.lastPresentedHaveNavigation {
                    lastListener?.dismissNotify(event: .userInitiative)
                } else {
                    lastListener?.decrement()
                }
            }
            completion?()
        }
    }
    
}

private extension ApplicationRouter {
    var lastPresented: UIViewController? {
        windowHierarchyHelper.topViewController()
    }
    
    var lastListener: LifeCycleListener? {
        listeners.reap()
        return listeners.lastWithObject?.object
    }
    
    var lastPresentedHaveNavigation: Bool {
        lastPresented?.navigationController != nil
    }
    
    var numberOfPresentedViewControllers: Int {
        var number = 0
        var controller = lastPresented

        while controller?.presentingViewController != nil {
            controller = controller?.presentingViewController
            number += 1
        }

        return number
    }
}

extension ApplicationRouter: UINavigationControllerDelegate {
    public func navigationController(
        _: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from _: UIViewController,
        to _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        defer {
            pushTransition = nil
            popTransition = nil
        }
        switch operation {
        case .push:
            return pushTransition?.animator

        case .pop:
            return popTransition?.animator

        case .none:
            return nil

        @unknown default: return nil
        }
    }

    public func navigationController(
        _ navigationController: UINavigationController,
        willShow _: UIViewController,
        animated _: Bool
    ) {
        navigationController.topViewController?.transitionCoordinator?.notifyWhenInteractionChanges { context in
            if !context.isCancelled {
                if let fromViewController = context.viewController(forKey: .from),
                   let swipeController = fromViewController as? ScreenSwiping {
                    swipeController.didSwipeViewController()
                }

                self.lastListener?.decrement()
            }
        }
    }
}
// MARK: - UIAdaptivePresentationControllerDelegate

extension ApplicationRouter: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        /*
         Важно!
         Если модуль который дисмиссится - UINavigationController, то необходимо вызвать dismissNotify
         Если модуль который дисмиссится - UIViewController, то необходимо вызвать decrement
         Почему? см. presentModule
         */
        if let navController = presentationController.presentedViewController as? UINavigationController {
            if let lastController = (navController.viewControllers.last as? ScreenSwiping) {
                lastController.didDismissBySwipe()
            }

            lastListener?.dismissNotify(event: .uikit)
        } else {
            if let lastController = presentationController.presentedViewController as? ScreenSwiping {
                lastController.didDismissBySwipe()
            }
            lastListener?.decrement()
        }
    }

    public func adaptivePresentationStyle(_: UIPresentationController) -> UIModalPresentationStyle {
        return lastPresented?.modalPresentationStyle ?? .automatic
    }
}

