//
//  LifeCycleListener.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

/// Интерфейс слушателя жизненного цикла юнитов в координаторах
public protocol LifeCycleListener: AnyObject {
    /// Сообщает о увеличении
    func increment()

    /// Сообщает об уменьшении
    func decrement()

    /// Сообщает о старте нового флоу
    func startNotify()

    /// Сообщает о дисмиссе флоу
    /// - Parameter event: тип эвента от роутера
    func dismissNotify(event: ApplicationRouter.RouterEvent)

    /// Сообщает о выходе до рутового флоу
    /// - Parameter router: рутовый роутер
    func toRootNofity(in router: Routable)

    /// Является ли координатор владельцем листнера
    /// - Parameter router: координатор
    func isListener(for coordinator: BaseCoordinator) -> Bool
}
