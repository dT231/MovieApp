//
//  WeakReference.swift
//  MAFoundation
//
//  Created by Dan Gorb on 05.10.2023.
//

import Foundation

public protocol WeakReferencing {
    associatedtype Value
    
    var object: Value? { get set }
}

public final class WeakReference<T>: WeakReferencing {
    private weak var _value: AnyObject?
    
    public var object: T? {
        get {
            _value as? T
        }
        set {
            guard let value = newValue else {
                _value = nil
                return
            }
            if isObject(newValue: value) {
                _value = value as AnyObject
            } else {
                _value = nil
            }
        }
    }
    
    public init(_ object: T) {
        self.object = object
    }
    
    private func isObject(newValue: Any) -> Bool {
        type(of: newValue) is AnyObject.Type
    }
    
}

public extension Array where Element: WeakReferencing {
    /// Removes elements with nil object
    mutating func reap() {
        self = filter { $0.object != nil }
    }

    /// Last element with not-nil object
    var lastWithObject: Element? {
        return last(where: { $0.object != nil })
    }
}
