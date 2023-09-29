//
//  WebViewInput.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public protocol WebViewInput: AnyObject {
    func configure(url: URL, couldOpenInSafari: Bool)
}

public extension WebViewInput {
    func configure(url: URL, couldOpenInSafari: Bool = true) {
        configure(url: url, couldOpenInSafari: couldOpenInSafari)
    }
}
