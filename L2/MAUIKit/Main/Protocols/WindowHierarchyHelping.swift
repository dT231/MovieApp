//
//  WindowHierarchyHelping.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 21.09.2023.
//

import Foundation
import UIKit

public protocol WindowHierarchyHelping {
    func rootViewController() -> UIViewController?
    func topViewController() -> UIViewController?
}

public class WindowHierarchyHelper: WindowHierarchyHelping {
    private let windowGetter: WindowGetting
    
    public init(windowHelper: WindowGetting) {
        windowGetter = windowHelper
    }
    
    public func rootViewController() -> UIViewController? {
        windowGetter.keyWindow()?.rootViewController
    }
    
    public func topViewController() -> UIViewController? {
        topVC(in: rootViewController())
    }
}

private extension WindowHierarchyHelper {
    func topVC(in viewController: UIViewController?) -> UIViewController? {
        if var topVC = viewController {
            while let presentedVC = topVC.presentedViewController, !presentedVC.isBeingDismissed {
                topVC = presentedVC
            }
            
            if let navController = topVC as? UINavigationController {
                return searchInto(vc: navController)
            }
            
            if let tabController = topVC as? UITabBarController {
                return searchInto(vc: tabController)
            }
            return topVC
        }
        
        return viewController
    }
    
    func searchInto(vc: UINavigationController) -> UIViewController?  {
        return topVC(in: vc.topViewController)
    }
    
    func searchInto(vc: UITabBarController) -> UIViewController? {
        guard let selectedViewController = vc.selectedViewController else { return nil }
        
        if let selectedNav = selectedViewController as? UINavigationController {
            return searchInto(vc: selectedNav)
        }
        return selectedViewController
    }
}
