//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.09.2023.
//

import SwiftUI

final class AppDelegate: UIResponder {
    var window: UIWindow?
    lazy var app: ApplicationProtocol = Application(window: &window)
}

extension AppDelegate: UIApplicationDelegate {
    
}
