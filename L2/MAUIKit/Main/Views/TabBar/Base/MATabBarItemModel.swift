//
//  MATabBarItemModel.swift
//  MAUIKit
//
//  Created by Dan Gorb on 15.10.2023.
//

import SwiftUI

public protocol MATabBarItemModelProtocol: AnyObject {
    var title: String? { get set }
}

/*
 Don't use it directly, only inheritance.
 For publishing changes in @Publised properties,
 you have to conform ObservableObject in subclasses for iOS 14.1-14.3

 Origin: Using Published in a subclass of a type
 conforming to ObservableObject now correctly publishes changes. (71816443)
 https://stackoverflow.com/questions/57615920/published-property-wrapper-not-working-on-subclass-of-observableobject
 */
public class MATabBarItemModel: MATabBarItemModelProtocol {
    @Published public var title: String?
    @Published var isSelected: Bool = false
    @Published var badgeIsHidden: Bool = true
    @Published var badgeColor: UIColor?

    public let type: SMTabBarItemType

    public init(
        type: SMTabBarItemType,
        title: String? = nil,
        badgeColor: UIColor? = nil
    ) {
        self.type = type
        self.title = title
        self.badgeColor = badgeColor
    }
}

extension MATabBarItemModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    public static func == (lhs: MATabBarItemModel, rhs: MATabBarItemModel) -> Bool {
        return lhs.type == rhs.type
            && lhs.title == rhs.title
            && lhs.isSelected == rhs.isSelected
    }
}
