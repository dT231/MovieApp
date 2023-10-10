//
//  Application.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.09.2023.
//

import MADependencies
import MAModulesInfrastructure

protocol ApplicationProtocol: AnyObject {
    var dependencyFactory: DependencyFactoryProtocol { get }
    var startupDecorators: [ApplicationDecorator] { get }
    
    func start()
}

open class Application: ApplicationProtocol {
    var dependencyFactory: DependencyFactoryProtocol
    
    var startupDecorators: [ApplicationDecorator] = []
    
    func start() {
        <#code#>
    }
    
    // MARK: Appropriated objects
    
    private let coordinatorFactory: CoordinatorFactoring
    private let moduleFactory: ModulesFactoring
    
    private var applicationCoordinator: (baseCoordinator: BaseCoordinator, AnyCoordinator)
    
}
