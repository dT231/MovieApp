//
//  StartupCoordinatorResult.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 11.10.2023.
//

import MADomainEntites

public enum StartupCoordinatorResult {
    case userFlowStart(entryPoint: UserFlowEntryPoint)
}
