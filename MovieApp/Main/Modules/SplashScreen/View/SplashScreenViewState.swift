//
//  SplashScreenViewState.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Foundation
import MAUIKit

final class SplashScreenViewState: ObservableObject {
    @Published var isRequestsInProgress = false
    @Published var isSplashAnimationPlaying = true
    @Published var errorOverlayModel: ErrorOverlayModel?
}
