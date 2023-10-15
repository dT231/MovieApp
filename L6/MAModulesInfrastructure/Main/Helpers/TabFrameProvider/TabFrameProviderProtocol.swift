//
//  TabFrameProviderProtocol.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.10.2023.
//

/// Placed in SMModulesInfrastructure to be available for common modules and main project
public protocol TabFrameProviderProtocol: AnyObject {
    /// Возвращает фрэйм таба
    /// - Parameter tab: таб, `CGRect` которого необходимо получить
    /// - Returns:  `CGRect` таба, `nil` если таб не найден
    func getTabFrame(for tab: RootTab) -> CGRect?
}

