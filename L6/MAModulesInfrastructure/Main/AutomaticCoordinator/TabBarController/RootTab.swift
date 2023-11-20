//
//  RootTab.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 15.10.2023.
//

public enum RootTab: Int, CaseIterable {
    case main = 0
    case catalog
    case favourites
    case profile
    //TODO: encapsulate logic of assets by SwiftGen
    
    public var info: TabBarItemInfo {
        switch self {
        case .main:
            return .init(
                title: "Главная",
                imageAssetName: "home-page",
                selectedImageAssetName: "home-page"
            )
        case .catalog:
            return .init(
                title: "Каталог",
                imageAssetName: "layers",
                selectedImageAssetName: "layers"
            )
        case .favourites:
            return .init(
                title: "Избранное",
                imageAssetName: "bookmark",
                selectedImageAssetName: "bookmark"
            )
            
        case .profile:
            return .init(
                title: "Профиль",
                imageAssetName: "user",
                selectedImageAssetName: "user"
            )
        }
    }
}
