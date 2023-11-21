//
//  CoordinatorFactory.swift
//  MovieApp
//
//  Created by Dan Gorb on 11.10.2023.
//

import Foundation
import MAModulesInfrastructure
import MADependencies

final class CoordinatorFactory: CoordinatorFactoring {
    private var modulesFactory: ModulesFactoring
    private var dependencyFactory: DependencyFactoryProtocol
    
    init(
        modulesFactory: ModulesFactoring,
        dependencyFactory: DependencyFactoryProtocol
    ) {
        self.modulesFactory = modulesFactory
        self.dependencyFactory = dependencyFactory
    }
    
    func makeApplicationCoordinator(router: Routable) -> AnyCoordinator<Void> {
        
        let applicationCoordinator = ApplicationCoordinator(
            router: router,
            coordinatorsFactory: self,
            modulesFactory: modulesFactory
        )
        
        return AnyCoordinator(applicationCoordinator)
    }
    
    func makeStartupCoordinator(output: BaseCoordinator & StartupCoordinatorOutput, router: Routable) -> AnyCoordinator<Void> {
        
        let startupCoordinator =
        StartupCoordinator(
            output: output,
            router: router,
            parent: output,
            modulesFactory: modulesFactory,
            coordinatorFactory: self,
            dependancyFactory: dependencyFactory
        )
        
        return AnyCoordinator(startupCoordinator)
    }
    
    func makeTabBarCoordinator(
        router: Routable,
        parent: BaseCoordinator,
        output: TabBarCoordinatorOutput
    ) -> AnyCoordinator<TabBarCoordinatorDeepLink> {
        let tabFactory = TabBarFactory()
        
        let tabBarCoordinator = TabBarCoordinator(
            router: router,
            parent: parent,
            output: output,
            coordinatorFactory: self,
            tabFactory: tabFactory,
            tabBarManager:
        )
    }
    
    func makeMainFlowCoordinator(
        output: MainFlowCoordinatorOutput,
        tabBarAppearanceManager: TabBarAppearanceManagerProtocol
    ) -> (Presentable, input: MainFlowCoordinatorInput) {
        <#code#>
    }
}
