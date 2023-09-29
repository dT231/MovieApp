//
//  SystemNavigationController.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.09.2023.
//

import UIKit

open class SystemNavigationController: UINavigationController, UIGestureRecognizerDelegate
{
    var popToRootHandler: (() -> Void)?
    
    override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        defer {
            popToRootHandler?()
        }
        return super.popToRootViewController(animated: animated)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        definesPresentationContext = false
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let topVC = topViewController as? ScreenSwiping, topVC.isSwipeEnabled else {
            return false
        }
        
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true
        }
        
        return viewControllers.count > 1 && presentedViewController == nil
    }
}
