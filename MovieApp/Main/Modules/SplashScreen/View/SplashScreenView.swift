//
//  SplashScreenView.swift
//  MovieApp
//
//  Created by Dan Gorb on 04.12.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject private var state: SplashScreenViewState
    
    private let output: SplashScreenOutput?
    
    init(output: SplashScreenOutput?, state: SplashScreenViewState) {
        self.output = output
        self.state = state
    }
    
    var body: some View {
        ZStack {
            if state.isSplashAnimationPlaying {
                
            } else if state.isRequestsInProgress {
                //spinner
            } else {
                // error
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
