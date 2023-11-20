//
//  StartupCoordinator.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.11.2023.
//

import MAModulesInfrastructure
import MADependencies

final class StartupCoordinator: BaseCoordinator {
    private weak var output: StartupCoordinatorOutput?
    
    private weak var splashScreenInput: SplashScreenInput?
    
    private let modulesFactory: ModulesFactoring
    private let coordinatorFactory: CoordinatorFactoring
    private let dependancyFactory: DependencyFactoryProtocol
    
    init(
        output: StartupCoordinatorOutput,
        router: Routable,
        parent: BaseCoordinator,
        modulesFactory: ModulesFactoring,
        coordinatorFactory: CoordinatorFactoring,
        dependancyFactory: DependencyFactoryProtocol
    ) {
        self.output = output
        self.modulesFactory = modulesFactory
        self.coordinatorFactory = coordinatorFactory
        self.dependancyFactory = dependancyFactory
        
        super.init(router: router, parent: parent)
    }
}

extension StartupCoordinator: Coordinator {
    func start(with option: Void) {
        showSplashScreen()
    }
}

extension StartupCoordinator: SplashScreenOutput {
    func splashScreenDidFinish(withResult result: SplashScreenResult) {
        switch result {
        case .userFlowStart(entryPoint: let entryPoint):
            output?.receiveResult(.userFlowStart(entryPoint: entryPoint))
        case .updateRequired:
            presentUpdateRequiredScreen()
        }
    }
}

private extension StartupCoordinator {
    func showSplashScreen() {
        let module = modulesFactory.makeSplashScreen(output: self)
    }
    
    func presentUpdateRequiredScreen() {
        //TODO: Present update required module
    }
}
