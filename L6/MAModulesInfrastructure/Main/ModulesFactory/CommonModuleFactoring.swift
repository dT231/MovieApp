//
//  CommonModuleFactoring.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public typealias ConcreteModule<T> = (view: Presentable, input: T)

public protocol CommonModuleFactoring {
    func makeWebView(coordinator: WebViewOutput) -> ConcreteModule<WebViewInput>
}
