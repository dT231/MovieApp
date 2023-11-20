//
//  Application.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.09.2023.
//

import MADependencies
import MAModulesInfrastructure
import UIKit

protocol ApplicationProtocol: AnyObject {
    var dependencyFactory: DependencyFactoryProtocol { get }
    var startupDecorators: [ApplicationDecorator] { get }
    
    func start()
}

open class Application: ApplicationProtocol {
 
    var dependencyFactory: DependencyFactoryProtocol
    
    // MARK: Service
//    private let logoutManager:
//    private let authOperationManager: AuthOperationManaging
    
    
    // MARK: Appropriated objects
    
    private let coordinatorFactory: CoordinatorFactoring
    private let moduleFactory: ModulesFactoring
    
    private var applicationCoordinator: BaseCoordinator
    private weak var window: ApplicationWindow?
    
    init(
        window: inout ApplicationWindow?
    ) {
        window = ApplicationWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.dependencyFactory = DependencyFactory()
        self.moduleFactory = ModulesFactory()
        self.coordinatorFactory = CoordinatorFactory(
            modulesFactory: moduleFactory,
            dependencyFactory: dependencyFactory
        )
    }
}
