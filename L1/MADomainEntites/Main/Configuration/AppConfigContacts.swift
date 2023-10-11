//
//  AppConfigContacts.swift
//  MADomainEntites
//
//  Created by Dan Gorb on 11.10.2023.
//

import Foundation

public struct AppConfigContacts {
    public let phone: String?
    public let email: String?
    public let whatsapp: String?
}

public extension AppConfigContacts {
    var isHasAnyContact: Bool {
        [phone, email, whatsapp].isEmpty
    }
}
