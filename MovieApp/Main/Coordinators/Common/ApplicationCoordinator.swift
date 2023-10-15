//
//  ApplicationCoordinator.swift
//  MovieApp
//
//  Created by Dan Gorb on 11.10.2023.
//

import Foundation
import MAModulesInfrastructure
import MADomainEntites

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorsFactory: CoordinatorFactoring
    private let modulesFactory: ModulesFactoring
    private let configurationService: ConfigurationServicing
    
    private var pendingFlowEntryPoint: UserFlowEntryPoint?
    
    init(
        router: Routable,
        coordinatorsFactory: CoordinatorFactoring,
        modulesFactory: ModulesFactoring,
        configurationService: ConfigurationServicing
    ) {
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        self.configurationService = configurationService
        
        super.init(router: router, parent: nil)
    }
}

// MARK: - Private

private extension ApplicationCoordinator {
    func start() {
        openStartupCoordinator()
    }
    
    func processUserFlowEntryPoint(_ entryPoint: UserFlowEntryPoint) {
        switch entryPoint {
        case .interestSelection:
            openTabBarCoordinator()
        }
    }
}


// MARK: - Coordinator

extension ApplicationCoordinator: Coordinator {
    func start(with _: AnyObject?) {
        start()
    }
}

// MARK: - Navigation

private extension ApplicationCoordinator {
    func openStartupCoordinator() {
        let coordinator = coordinatorsFactory.makeStartupCoordinator(
            output: self,
            router: router
        )
        coordinator.start()
    }
    
    func openTabBarCoordinator(deeplink: TabBarCoordinator.Deeplink = .appLaunch) {
        let coordinator = coordinatorsFactory.makeTabBarCoordinator(router: router, parent: self, output: self)
        coordinator.start(with: deeplink)
    }
}


//MARK: - StartupCoordinatorOutput
extension ApplicationCoordinator: StartupCoordinatorOutput {
    func receiveResult(_ result: MAModulesInfrastructure.StartupCoordinatorResult) {
        switch result {
        case let .userFlowStart(entryPoint):
            processUserFlowEntryPoint(entryPoint)
        }
    }
    
}
 
// MARK: - TabBarCoordinatorOutput

extension ApplicationCoordinator: TabBarCoordinatorOutput {
    func receiveResult(_ result: TabBarCoordinatorResult) {
        switch result {
        case .restartApplication:
            openAddressSelectionCoordinator()
    }
}
