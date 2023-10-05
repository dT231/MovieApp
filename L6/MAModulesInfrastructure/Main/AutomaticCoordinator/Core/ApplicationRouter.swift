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
        <#code#>
    }
    
    public func isLast(module: Presentable) -> Bool {
        <#code#>
    }
    
    public func isVisible(_ module: Presentable) -> Bool {
        <#code#>
    }
    
    public var isModallyPresented: Bool {
        <#code#>
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
