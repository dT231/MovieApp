//
//  ModulesFactory.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Foundation
import MADependencies
import MAModulesInfrastructure

final class ModulesFactory: ModulesFactoring {
    private let dependancyFactory: DependencyFactoryProtocol
    
    init(dependancyFactory: DependencyFactoryProtocol) {
        self.dependancyFactory = dependancyFactory
    }
    
    func makeSplashScreen(output: SplashScreenOutput) -> ConcreteModule<SplashScreenInput> {
        let module = SplashScreenConfigurator(dependancyFactory: dependancyFactory)
            .configure()
        
        return module
    }
}
