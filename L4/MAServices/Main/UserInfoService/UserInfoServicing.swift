//
//  UserInfoServicing.swift
//  MAServices
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine

public protocol UserInfoServicing {
    func loadUserInfo() -> AnyPublisher<Void, Error>
}
