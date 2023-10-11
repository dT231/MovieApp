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
    
    func makeApplicationCoordinator() -> BaseCoordinator {
        let applicationCoordinator = ApplicationCoo
    }
}
