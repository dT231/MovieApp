//
//  SystemHostingController.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.09.2023.
//

import Foundation
import UIKit
import SwiftUI
import MAUIKit

public protocol ScreenSwiping {
    var isSwipeEnabled: Bool { get }
    
    func didSwipeViewController()
    
    func didDismissBySwipe()
}

public final class SystemHostingController<RootView: View>: UIHostingController<RootView> {
    public weak var delegate: SystemHostingControllerDelegate?
    
    public let isSwipeEnabled: Bool
    
    public var screenName: String?
    
    private var isWillAppearCallOnce = false
    private var isDidAppearCalledOnce = false
    private var inputStyle: UIStatusBarStyle?
    
    public init(
        rootView: RootView,
        screenName: String? = nil,
        isSwipeEnabled: Bool = true
    ) {
        self.screenName = screenName
        self.isSwipeEnabled = isSwipeEnabled
        
        super.init(rootView: rootView)
        definesPresentationContext = false
    }
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return inputStyle ?? delegate?.preferredStatusBarStyle ?? .default
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notifyWillAppearFirstTimeIfNeeded(animated)
        delegate?.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notifyDidAppearFirstTimeIfNeeded(animated)
        delegate?.viewDidAppear(animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.viewWillDisappear(animated)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidDisappear(animated)
    }
    
    
    // MARK: Private
    private func notifyWillAppearFirstTimeIfNeeded(_ animated: Bool) {
        if !isWillAppearCallOnce {
            delegate?.viewWillAppearFirstTime(animated)
            isWillAppearCallOnce = true
        }
    }
    
    private func notifyDidAppearFirstTimeIfNeeded(_ animated: Bool) {
        if !isDidAppearCalledOnce {
            delegate?.viewDidAppearFirstTime(animated)
            isDidAppearCalledOnce = true
        }
    }
    
}
 
extension SystemHostingController: SystemHostingControllerInput {
    public func setStatusBarStyle(_ style: UIStatusBarStyle, animated: Bool) {
        inputStyle = style
        guard animated else {
            setNeedsStatusBarAppearanceUpdate()
            return
        }
        UIView.animate(withDuration: Constants.AnimationDurations.defaultApple, animations: setNeedsStatusBarAppearanceUpdate)
    }
}

extension SystemHostingController: ScreenSwiping {
    public func didSwipeViewController() {
        delegate?.didSwipeBack()
    }
    
    public func didDismissBySwipe() {
        delegate?.didDismissBySwipe()
    }
    
}
