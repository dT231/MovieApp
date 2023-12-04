//
//  UserInfoService.swift
//  MAServices
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine

final public class UserInfoService {
    
}

extension UserInfoService: UserInfoServicing {
    public func loadUserInfo() -> AnyPublisher<Void, Error> {
//        Just("").setFailureType(to: Error.self).eraseToAnyPublisher()
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
