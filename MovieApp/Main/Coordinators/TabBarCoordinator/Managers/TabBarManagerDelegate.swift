//
//  TabBarManagerDelegate.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.10.2023.
//

import MAModulesInfrastructure

protocol TabBarManagerDelegate: AnyObject {
    /// Уведомляет делегата о том, что активная вкладка нажата повторно
    /// - Parameter tab: вкладка
    func repeatedTap(tab: RootTab)

    /// Уведомляет делегата о том, что выбрана вкладка
    /// - Parameters:
    ///   - tab: вкладка
    ///   - previousTab: предыдущая вкладка
    func didSelectTab(tab: RootTab, previousTab: RootTab)
}
