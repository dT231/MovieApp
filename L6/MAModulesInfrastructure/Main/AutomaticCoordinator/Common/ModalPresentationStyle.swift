//
//  ModalPresentationStyle.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//
import UIKit

/// Абстракция от UIKit'a
public enum ModalPresentationStyle {
    case pageSheet
    case fullScreen
    case overFullScreen
    case automatic

    var uiModalPresentationStyle: UIModalPresentationStyle {
        switch self {
        case .pageSheet: return .pageSheet
        case .overFullScreen: return .overFullScreen
        case .automatic: return .automatic
        case .fullScreen: return .fullScreen
        }
    }
}
