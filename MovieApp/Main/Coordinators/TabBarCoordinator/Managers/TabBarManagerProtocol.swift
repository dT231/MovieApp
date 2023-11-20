//
//  TabBarManagerProtocol.swift
//  MovieApp
//
//  Created by Dan Gorb on 15.10.2023.
//

import MAModulesInfrastructure
import MAUIKit

protocol TabBarManagerProtocol: TabFrameProviderProtocol, TabBarAppearanceManagerProtocol {
    typealias PresentableTab = (presentable: Presentable, tabItem: MATabBarItemModelProtocol)

    /// Устанавливает массив табов и массив объектов в качестве контроллеров табов
    /// - Parameters:
    ///   - presentables: массив кортежей, которые будут отображены в табах
    ///   - animated: флаг анимации, по умолчанию: true
    func setPresentable(_ presentables: [PresentableTab], animated: Bool)

    /// Выбрать вкладку
    func select(tab: RootTab)

    /// Текущая выбранная вкладка
    var selectedTab: RootTab { get }

    /// Закрытый протоколом таббар
    var tabBarPresentable: Presentable { get }

    /// Делегат менеджера
    var delegate: TabBarManagerDelegate? { get set }
}

extension TabBarManagerProtocol {
    func setPresentable(_ presentables: [PresentableTab], animated: Bool = false) {
        setPresentable(presentables, animated: animated)
    }
}

