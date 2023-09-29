//
//  ModalTransitionStyle.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//
import UIKit

/// Абстракция от UIKit'a
public enum ModalTransitionStyle {
    case coverVertical
    case flipHorizontal
    case crossDissolve
    case partialCurl

    var uiModalTransitionStyle: UIModalTransitionStyle {
        switch self {
        case .coverVertical: return .coverVertical
        case .flipHorizontal: return .flipHorizontal
        case .crossDissolve: return .crossDissolve
        case .partialCurl: return .partialCurl
        }
    }
}
