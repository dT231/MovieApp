//
//  TabFactoryProtocol.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.10.2023.
//

import MAUIKit
import MAModulesInfrastructure

protocol TabBarFactoryProtocol {
    func makeBarItem(for tab: RootTab) -> MATabBarItemModelProtocol
}
