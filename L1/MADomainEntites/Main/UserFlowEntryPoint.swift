//
//  UserFlowEntryPoint.swift
//  MADomainEntites
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public enum UserFlowEntryPoint: Equatable {
    /// Open tabbar, process pending deeplink
    case pendingDeeplink

    /// There is an address and possibly a selected store. Open tabbar and store selection screen
//    case storeSelection

    /// Initial opening, need to start with movie kind interest selection
    case interestSelection
}
