//
//  TabFactory.swift
//  MovieApp
//
//  Created by Dan Gorb on 20.11.2023.
//

import MAUIKit
import MAModulesInfrastructure
import UIKit

final class TabBarFactory: TabBarFactoryProtocol {
    func makeBarItem(for tab: RootTab) -> MATabBarItemModelProtocol {
        return UITabBarItem(rootTab: tab).decorateBarItem()
    }
}

private extension UITabBarItem {
    convenience init(rootTab: RootTab) {
        self.init(
            title: rootTab.info.title,
            image: rootTab.info.imageAsset,
            selectedImage: rootTab.info.selectedImageAsset
        )
    }
    
    func decorateBarItem() -> UITabBarItem {
        accessibilityIdentifier = "TabItem"
        imageInsets = .init(top: 2, left: 0, bottom: -2, right: 0)
        return self
    }
}
