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
    
    func getTabFrame(for tab: MAModulesInfrastructure.RootTab) -> CGRect? {
        guard let tabIndex = getTabIndex(by: tab) else {
            return nil
        }
        
        let frames: [CGRect] = tabBarController.tabBar.subviews
            .compactMap { $0.frame }
            .sorted { $0.origin.x < $1.origin.x }
        
        guard var tabFrame = frames[safe: tabIndex] else {
            return nil
        }
        
        tabFrame = tabFrame.insetBy(dx: 0, dy: -4)
        
        let globalOriginY = tabBarController.tabBar.frame.minY
        var outFrame = tabFrame
        outFrame.origin.y = globalOriginY
        
        return outFrame
    }
    
    func showTabBar(animated: Bool) {
        setTabBarHidden(false, animated: animated)
    }
    
    func hideTabBar(animated: Bool) {
        setTabBarHidden(true, animated: animated)
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        tabBarController.setTabBarHidden(hidden, animated: animated)
    }
    
    var selectedTab: MAModulesInfrastructure.RootTab {
        guard let maxIndex = RootTab.allCases.map({ $0.rawValue }).max(), tabBarController.selectedIndex <= maxIndex else {
            assertionFailure("Ошибка получения выбранного индекса в таббаре(")
            return .main
        }
        
        return RootTab(rawValue: tabBarController.selectedIndex) ?? .main
    }
    
    var tabBarPresentable: MAModulesInfrastructure.Presentable {
        tabBarController
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
