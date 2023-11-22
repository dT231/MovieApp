//
//  MainFlowCoordinatorInput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.10.2023.
//

public protocol MainFlowCoordinatorInput: AnyObject {
    func open(deepLink: MainFlowCoordinatorDeepLink)
}
