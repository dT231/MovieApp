//
//  main.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.09.2023.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let realAppDelegateClass = NSStringFromClass(AppDelegate.self)

let appDelegateClass = isRunningTests ? nil : realAppDelegateClass

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
