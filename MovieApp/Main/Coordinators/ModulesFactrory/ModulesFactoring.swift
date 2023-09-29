//
//  ModulesFactoring.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation
import MAModulesInfrastructure

protocol ModulesFactoring {
    func makeSplashScreen(output: SplashScreenOutput) -> ConcreteModule<SplashScreenInput>
}
