//
//  BaseCoordintator.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

open class BaseCoordinator {
    private enum LocalConstants {
        static let applicationCoordinator = "MovieApp.ApplicationCoordinator"
    }
    
    /// Роутер координатора
    public let router: Routable

    /// Родительский координатор
    private weak var parentCoordinator: BaseCoordinator?
    
    /// Дочерние координаторы
    private var childCoordinators: [BaseCoordinator] = []
    
    /// Свойство позволяет понять как показан координатор, из коробки или нет
    private var isStartingWithCoordinator = false
    
    /// Свойство позволяет считать кол-во юнитов в координаторе
    public private(set) var countUnits: Int = 0
}
