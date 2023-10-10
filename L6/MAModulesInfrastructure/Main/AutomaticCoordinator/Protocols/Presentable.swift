//
//  Presentable.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import UIKit

/// Абстракция от UIKit'a
public protocol Presentable: AnyObject {
    var toPresent: UIViewController { get }
}

extension UIViewController: Presentable {
    public var toPresent: UIViewController { self }
}
