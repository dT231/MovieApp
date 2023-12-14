//
//  ErrorOverlayModel+.swift
//  MAUIKit
//
//  Created by Dan Gorb on 14.12.2023.
//

import Foundation
import UIKit

public extension ErrorOverlayModel {
    static func networkModel(
        buttonTapHandler: (() -> Void)? = nil
    ) -> Self {
        .init(
            icon: UIImage(systemName: "xmark.app.fill")!,
            title: "что-то пошло не так".uppercased(),
            message: "Попробуйте обновить страницу или отключить VPN, если он работает",
            buttonTitle: "обновить",
            tapHandler: buttonTapHandler ?? {}
        )
    }
}
