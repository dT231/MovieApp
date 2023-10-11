//
//  TabBarCoordinatorOutput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 11.10.2023.
//
public protocol TabBarCoordinatorOutput: AnyObject {
    func receiveResult(_ result: TabBarCoordinatorResult)
}
