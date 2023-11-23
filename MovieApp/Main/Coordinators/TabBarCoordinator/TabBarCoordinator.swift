//
//  TabBarCoordinator.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.10.2023.
//

import Foundation
import MAModulesInfrastructure

final class TabBarCoordinator: BaseCoordinator {
    typealias DeepLink = TabBarCoordinatorDeepLink
    
    private weak var output: TabBarCoordinatorOutput?
    
    private let coordinatorFactory: CoordinatorFactoring
    private let tabFactory: TabBarFactoryProtocol
    private let tabBarManager: TabBarManagerProtocol
    
    init(
        router: Routable,
        parent: BaseCoordinator,
        output: TabBarCoordinatorOutput,
        coordinatorFactory: CoordinatorFactoring,
        tabFactory: TabBarFactoryProtocol,
        tabBarManager: TabBarManagerProtocol
    ) {
        self.output = output
        self.coordinatorFactory = coordinatorFactory
        self.tabFactory = tabFactory
        
        super.init(router: router, parent: parent)
    }
}

extension TabBarCoordinator: Coordinator {
    func start(with option: DeepLink) {
        tabBarManager.delegate = self
        prepareTabs(deepLink: option)
    }
}

// MARK: Private

private extension TabBarCoordinator {
    func prepareTabs(deepLink: DeepLink) {
        let presentables = [
            makeMainTab(deepLink: deepLink),
            makeCatalogTab(),
            makeProfileTab()
        ]
        
        tabBarManager.setPresentable(presentables, animated: false)
        
        router.setRootModule(tabBarManager.tabBarPresentable, transition: .fade)
    }
    
    func makeMainTab(deepLink: DeepLink) -> TabBarManagerProtocol.PresentableTab {
        let unit = coordinatorFactory.makeMainFlowCoordinator(
            output: self,
            tabBarAppearanceManager: tabBarManager
        )
        
        switch deepLink {
        case .appLaunch:
            unit.input.open(deepLink: .interestsSelection)
        case .afterInterestSelection:
            unit.input.open(deepLink: .main)
        }
    }
    func makeCatalogTab() -> TabBarManagerProtocol.PresentableTab {
    }
    
    func makeProfileTab() -> TabBarManagerProtocol.PresentableTab {
    }
    
}

extension TabBarCoordinator: TabBarManagerDelegate {
    func repeatedTap(tab: MAModulesInfrastructure.RootTab) {
        <#code#>
    }
    
    func didSelectTab(tab: MAModulesInfrastructure.RootTab, previousTab: MAModulesInfrastructure.RootTab) {
        <#code#>
    }
}

extension TabBarCoordinator: MainFlowCoordinatorOutput {
    func receiveResults(_ receive: MAModulesInfrastructure.MainFlowCoordinatorResult) {
        <#code#>
    }
}
