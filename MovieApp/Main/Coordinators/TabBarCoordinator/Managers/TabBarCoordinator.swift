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
    private let tabFactory: TabFactoryProtocol
    private let tabBarManager: TabBarManagerProtocol
    
    init(
        router: Routable,
        parent: BaseCoordinator,
        output: TabBarCoordinatorOutput,
        coordinatorFactory: CoordinatorFactoring,
        tabFactory: TabFactoryProtocol,
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
    }
}

// MARK: Private

private extension TabBarCoordinator {
    func prepareTabs(deepLink: DeepLink) {
        
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
