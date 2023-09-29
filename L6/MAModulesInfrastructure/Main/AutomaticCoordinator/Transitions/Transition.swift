//
//  Transitions.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import UIKit

public enum Transition {
    case fade
    case dismiss
    case present
    
    var animator: UIViewControllerAnimatedTransitioning {
        switch self {
            case .fade: return FadeAnimator()
            case .dismiss: return DismissAnimator()
            case .present: return PresentAnimator()
        }
    }
}
