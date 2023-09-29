//
//  SystemHostingControllerInput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.09.2023.
//

import UIKit

/// Input interface SystemHostingController
public protocol SystemHostingControllerInput: AnyObject {
    /// Set bar status style
    /// - Parameter style: statusBar style
    /// - Parameter animated: animation flag
    func setStatusBarStyle(_ style: UIStatusBarStyle, animated: Bool)
}

public extension SystemHostingControllerInput {
    func setStatusBarStyle(_ style: UIStatusBarStyle, animated: Bool = true) {
        setStatusBarStyle(style, animated: animated)
    }
}
