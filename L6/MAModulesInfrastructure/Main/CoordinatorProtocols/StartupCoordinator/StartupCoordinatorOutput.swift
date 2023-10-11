//
//  StartupCoordinatorOutput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 11.10.2023.
//

public protocol StartupCoordinatorOutput: AnyObject {
    func receiveResult(_ result: StartupCoordinatorResult)
}
