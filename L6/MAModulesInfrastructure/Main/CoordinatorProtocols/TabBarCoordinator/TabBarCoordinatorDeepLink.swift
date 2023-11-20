//
//  TabBarCoordinatorDeepLink.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 11.10.2023.
//

public enum TabBarCoordinatorDeepLink {
    case appLaunch
    case afterInterestSelection
}

//extension TabBarCoordinatorDeepLink: Equatable {
//    public static func == (lhs: TabBarCoordinatorDeepLink, rhs: TabBarCoordinatorDeepLink) -> Bool {
//        switch (lhs, rhs) {
//        case (.appLaunch, .appLaunch),
//            (.afterInterestSelection, .afterInterestSelection):
//            return true
//            
//        default: return false
//        }
//    }
//}
