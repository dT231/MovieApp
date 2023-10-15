//
//  TabFactoryProtocol.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.10.2023.
//

import MAUIKit
import MAModulesInfrastructure

protocol TabFactoryProtocol {
    func makeBarItem(for tab: RootTab) -> SMTabBarItemModelProtocol
}
