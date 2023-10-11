//
//  AppConfig.swift
//  MAServices
//
//  Created by Dan Gorb on 11.10.2023.
//

public struct AppConfig {
    public let privacyTermsLink: String
    public let authentication: AppConfigAuthentication
    public let contacts: AppConfigContacts
    public let appVersions: AppConfigVersions?
    public let webViewWhitelist: [String]?
}
