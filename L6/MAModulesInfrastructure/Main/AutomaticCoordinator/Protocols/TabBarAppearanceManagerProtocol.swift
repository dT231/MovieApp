//
//  TabBarAppearanceManagerProtocol.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.10.2023.
//

public protocol TabBarAppearanceManagerProtocol: AnyObject {
    func showTabBar(animated: Bool)

    func hideTabBar(animated: Bool)

    func setTabBarHidden(_ hidden: Bool, animated: Bool)
}
