//
//  ApplicationWindow.swift
//  MovieApp
//
//  Created by Dan Gorb on 10.10.2023.
//

import UIKit
import MAModulesInfrastructure

final class ApplicationWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        rootViewController = SystemNavigationController()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
