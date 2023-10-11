//
//  CoordinatorFactoring.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public protocol CoordinatorFactoring {
    func makeStartupCoordinator(
        output: StartupCoordinatorOutput & BaseCoordinator,
        router: Routable
    ) -> AnyCoordinator<Void>
    
    func makeTabBarCoordinator(
        router: Routable,
        parent: BaseCoordinator,
        output: TabBarCoordinatorOutput
    ) -> AnyCoordinator<TabBarCoordinatorDeepLink>
}
