//
//  TabBarManager.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.11.2023.
//

import Foundation
import MAModulesInfrastructure
import UIKit

final class TabBarManager: NSObject {
    private var tabBarController: SystemTabBarController
    private var previousSelectedIndex: Int
    
    weak var delegate: TabBarManagerDelegate?
    
    init(tabBarController: SystemTabBarController) {
        self.tabBarController = tabBarController
        self.previousSelectedIndex = tabBarController.selectedIndex
        
        super.init()
        
        self.tabBarController.delegate = self
    }
    
    private func getTabIndex(by rootTab: RootTab) -> Int? {
        guard let controllerCount = tabBarController.viewControllers?.count else {
            assertionFailure("Не найдены контроллеры в таббаре(")
            return nil
        }
        
        return min(rootTab.rawValue, controllerCount - 1)
    }
}

extension TabBarManager: TabBarManagerProtocol {
    func setPresentable(_ presentables: [PresentableTab], animated: Bool) {
        presentables.forEach { presentable, tab in
            presentable.toPresent.tabBarItem = tab as? UITabBarItem
        }
        
        tabBarController.setViewControllers(presentables.map(\.presentable.toPresent), animated: animated)
    }
    
    func select(tab: MAModulesInfrastructure.RootTab) {
        guard let selectedIndex = getTabIndex(by: tab) else {
            return
        }
        
        previousSelectedIndex = tabBarController.selectedIndex
        tabBarController.selectedIndex = selectedIndex
    }
    
    var selectedTab: MAModulesInfrastructure.RootTab {
        <#code#>
    }
    
    var tabBarPresentable: MAModulesInfrastructure.Presentable {
        <#code#>
    }
    
    func getTabFrame(for tab: MAModulesInfrastructure.RootTab) -> CGRect? {
        <#code#>
    }
    
    func showTabBar(animated: Bool) {
        <#code#>
    }
    
    func hideTabBar(animated: Bool) {
        <#code#>
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        <#code#>
    }
}

extension TabBarManager: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            assertionFailure("Не найдены индекс выбранного контроллера в таббаре(")
            return
        }
        
        let selectedTab = RootTab(rawValue: selectedIndex) ?? .main
        let previousTab = RootTab(rawValue: previousSelectedIndex) ?? .main
        if selectedIndex == previousSelectedIndex {
            delegate?.repeatedTap(tab: selectedTab)
        }
        delegate?.didSelectTab(tab: selectedTab, previousTab: previousTab)
        
        previousSelectedIndex = selectedIndex
    }
}
