//
//  WebViewOutput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public protocol WebViewOutput: AnyObject {
    func webViewDidRequestClose()
}
