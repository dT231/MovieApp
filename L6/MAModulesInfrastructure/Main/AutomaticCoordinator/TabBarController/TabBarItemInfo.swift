//
//  TabItemInfo.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.11.2023.
//

import Foundation
import UIKit

//TODO: encapsulate logic of assets by SwiftGen
public struct TabBarItemInfo {
    public let title: String
    
    public var imageAsset: UIImage {
        guard let image = UIImage(named: imageAssetName) else {
            fatalError("Unable to load image asset named \(imageAssetName).")
        }
        return image
    }
    public var selectedImageAsset: UIImage {
        guard let image = UIImage(named: selectedImageAssetName) else {
            fatalError("Unable to load image asset named \(selectedImageAssetName).")
        }
        
        return image
    }
    
    private let imageAssetName: String
    private let selectedImageAssetName: String
    
    internal init(
        title: String,
        imageAssetName: String,
        selectedImageAssetName: String
    ) {
        self.title = title
        self.imageAssetName = imageAssetName
        self.selectedImageAssetName = selectedImageAssetName
    }
}
