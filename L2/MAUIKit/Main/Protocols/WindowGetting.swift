//
//  WindowGetting.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 21.09.2023.
//

import UIKit

/// Wrapper for object which returns window information
public protocol WindowGetting {
    func keyWindow() -> UIWindow?
}
