//
//  SplashScreenPresenter.swift
//  MovieApp
//
//  Created by Dan Gorb on 04.12.2023.
//

import Combine

final class SplashScreenPresenter {
    enum Request: Int, CaseIterable {
        case configuration
        case userInfo
        case moviesGenres
        
        var isMandatory: Bool {
            switch self {
            case .configuration:
                return true
            default:
                return false
            }
        }
    }
    
    private let interactor: SplashScreenInteracting
    private let viewState: SplashScreenViewState
    private let output: SplashScreenOutput
    
    private var splashAnimationSubscriptions: AnyCancellable?
    private var requestSubscription: AnyCancellable?
    private var subscriptions = Set<AnyCancellable>()
    private var succeededRequests: [Request] = []
    
    init(
        interactor: SplashScreenInteracting,
        viewState: SplashScreenViewState,
        output: SplashScreenOutput
    ) {
        self.interactor = interactor
        self.viewState = viewState
        self.output = output
    }
}

//MARK: Private

private extension SplashScreenPresenter {
    func publisher(for request: Request) -> AnyPublisher<Void, Error> {
        Deferred { [interactor] in
            switch request {
            case .configuration:
                return interactor.loadAppConfiguration()
            case .moviesGenres:
                return interactor.loadMovieGenre()
            case .userInfo:
                return interactor.loadUserProfile()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func loadAllData() {
        viewState.isRequestsInProgress = true
        let requestToPerform = Request.allCases.filter {
            !succeededRequests.contains($0)
        }
        let publishers: [AnyPublisher<Request?, Error>] = requestToPerform.map { request in
            publisher(for: request)
                .map { request }
        }
    }
}
