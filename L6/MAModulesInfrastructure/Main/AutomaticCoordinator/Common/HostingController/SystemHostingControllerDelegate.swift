//
//  SystemHostingControllerDelegate.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.09.2023.
//

import UIKit

public protocol SystemHostingControllerDelegate: AnyObject {
    func viewWillAppearFirstTime(_: Bool)
    func viewWillAppear(_ animated: Bool)
    func viewDidAppearFirstTime(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)

    /// User did successfully swipe back
    func didSwipeBack()

    /// User did dismiss by swipe
    func didDismissBySwipe()

    var preferredStatusBarStyle: UIStatusBarStyle { get }
}

public extension SystemHostingControllerDelegate {
    func viewWillAppearFirstTime(_: Bool) {}
    func viewWillAppear(_: Bool) {}
    func viewDidAppearFirstTime(_: Bool) {}
    func viewDidAppear(_: Bool) {}
    func viewWillDisappear(_: Bool) {}
    func viewDidDisappear(_: Bool) {}
    func didSwipeBack() {}
    func didDismissBySwipe() {}

    var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
