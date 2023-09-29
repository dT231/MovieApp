//
//  CloseModuleAction.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public struct CloseModuleAction: OptionSet {
    public let rawValue: Int
    
    public static let dismiss = CloseModuleAction(rawValue: 1 << 0)
    public static let pop = CloseModuleAction(rawValue: 1 << 1)
    public static let all: CloseModuleAction = [.dismiss, .pop]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
