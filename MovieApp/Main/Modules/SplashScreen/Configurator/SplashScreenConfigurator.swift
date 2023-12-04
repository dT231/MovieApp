//
//  SplashScreenConfigurator.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Foundation
import MAModulesInfrastructure
import MADependencies

final class SplashScreenConfigurator {
    private let dependancyFactory: DependencyFactoryProtocol
    
    init(dependancyFactory: DependencyFactoryProtocol) {
        self.dependancyFactory = dependancyFactory
    }
    
    func configure() -> ConcreteModule<SplashScreenInput> {
        let viewState = SplashScreenViewState()
        let interactor = SplashScreenInteractor(
            userInfoService: dependancyFactory.userInfoService,
            configService: dependancyFactory.configurationService,
            moviesService: dependancyFactory.moviesService
        )
        let presenter = 
    }
}
