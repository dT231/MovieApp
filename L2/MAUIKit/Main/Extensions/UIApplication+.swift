//
//  UIApplication+.swift
//  MAUIKit
//
//  Created by Dan Gorb on 21.09.2023.
//

import UIKit

extension UIApplication: WindowGetting {
    // Do not use windows?.first because we need to work only with window on active scene
    // https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
    public func keyWindow() -> UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .last { $0.isKeyWindow }    
    }
}
