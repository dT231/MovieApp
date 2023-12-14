//
//  ErrorOverlay.swift
//  MAUIKit
//
//  Created by Dan Gorb on 13.12.2023.
//

import SwiftUI

public struct ErrorOverlayModel {
    public let icon: UIImage
    public let title: String
    public let message: String
    public let buttonTitle: String
    public let tapHandler: () -> Void
    
    init(
        icon: UIImage,
        title: String,
        message: String,
        buttonTitle: String,
        tapHandler: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.tapHandler = tapHandler
    }
}
