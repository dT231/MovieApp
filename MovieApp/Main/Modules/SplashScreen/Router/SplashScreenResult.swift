//
//  SplashScreenResult.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation
import MADomainEntites

public enum SplashScreenResult {
    case userFlowStart(entryPoint: UserFlowEntryPoint)
    case updateRequired
    case emergencyWebViewRequired(url: URL)
}
