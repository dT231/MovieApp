//
//  MainFlowCoordinator.swift
//  MAMainScenes
//
//  Created by Dan Gorb on 22.11.2023.
//

import Foundation
import MAModulesInfrastructure

public final class MainFlowCoordinator: BaseCoordinator {
    private weak var output: MainFlowCoordinatorOutput?
    private let coordinatorsFactory: CoordinatorFactoring
    private let tabBarAppearanceManager: TabBarAppearanceManagerProtocol
    
    public init(
        output: MainFlowCoordinatorOutput,
        router: Routable,
        coordinatorsFactory: CoordinatorFactoring,
        tabBarAppearanceManager: TabBarAppearanceManagerProtocol
    ) {
        self.output = output
        self.coordinatorsFactory = coordinatorsFactory
        self.tabBarAppearanceManager = tabBarAppearanceManager
        
        super.init(router: router, parent: output)
    }
}

extension MainFlowCoordinator: Coordinator {
    public func start(with deepLink: MainFlowCoordinatorDeepLink) {
        open(deepLink: deepLink)
    }
}

extension MainFlowCoordinator: MainFlowCoordinatorInput {
    public func open(deepLink: MainFlowCoordinatorDeepLink) {
        switch deepLink {
        case .interestsSelection:
            openInterestSelection()
        case .main:
            openMainScreen(animated: true)
        }
    }
}

// MARK: - Routing
extension MainFlowCoordinator {
    func openInterestSelection() {
        //TODO: route to interest module
    }
    
    func openMainScreen(animated: Bool) {
        // TODO: Route to mainPage
    }
}
