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
    func loadUserInfo() -> AnyPublisher<String, Error> {
        Just("").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
