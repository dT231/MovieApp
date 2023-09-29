//
//  SplashScreenOutput.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public protocol SplashScreenOutput: AnyObject {
    func splashScreenDidFinish(withResult result: SplashScreenResult)
}
