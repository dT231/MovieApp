//
//  MainFlowCoordinatorOutput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.10.2023.
//

public protocol MainFlowCoordinatorOutput: BaseCoordinator {
    func receiveResults(_ receive: MainFlowCoordinatorResult)
}
