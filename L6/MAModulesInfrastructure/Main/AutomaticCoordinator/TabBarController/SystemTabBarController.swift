//
//  SystemTabBarController.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.11.2023.
//

import Foundation
import UIKit

public final class SystemTabBarController: UITabBarController {
    private lazy var appearanceAnimator: TabBarAppearanceAnimator = .init(tabBarController: self)
}
// MARK: - Show/Hide tabBar

public extension SystemTabBarController {
    func setTabBarHidden(
        _ hidden: Bool,
        animated: Bool = true
    ) {
        appearanceAnimator.setTabBarHidden(hidden, animated: animated)
    }
}

//TODO: separate file
public class TabBarAppearanceAnimator {
    private weak var tabBarController: UITabBarController?
    
    public init(tabBarController: UITabBarController?) {
        self.tabBarController = tabBarController
    }
    
    public func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        
    }
}
