//
//  Collection+.swift
//  MAFoundation
//
//  Created by Dan Gorb on 21.11.2023.
//

import Foundation

public extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            let element = self[unmanagedSafe: index]
            return element
        }
        set {
            if indices.contains(index) {
                if let value = newValue {
                    self[index] = value
                }
            }
        }
    }
    
    subscript(unmanagedSafe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
