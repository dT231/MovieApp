//
//  SplashScreenPresenter.swift
//  MovieApp
//
//  Created by Dan Gorb on 04.12.2023.
//

import Combine
import MAAPI

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
    private let scheduler: some Scheduler<RunLoop> = RunLoop.main
    
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
            // Return Request (not Void) to store it in succeededRequests
                .map { request }
                .catch { [weak self] error -> AnyPublisher<Request?, Error> in
                    if self?.isAccessDeniedError(error) ?? false {
                        return Fail(error: error).eraseToAnyPublisher()
                    } else {
                        return Result.Publisher(nil).eraseToAnyPublisher()
                    }
                }.eraseToAnyPublisher()
        }
        
        let allRequestsPublisher = Publishers.MergeMany(publishers)
        // Filter nil (=failed) requests
            .compactMap { $0 }
        // Collect all values and publish it as array. It allows not to trigger main queue for every request
            .collect()
            .receive(on: scheduler)
            .eraseToAnyPublisher()
        
        requestSubscription = allRequestsPublisher.sink(receiveCompletion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .finished:
                if isAllMandatoryRequestsSucceeded {
                    let startRequestBlock = {
                        
                    }
                }
            case .failure(_):
                viewState.errorOverlayModel = .networkModel(buttonTapHandler: { [weak self] in
                    self?.loadAllData()
                })
            }
        }, receiveValue: { [weak self] result in
            self?.succeededRequests.append(contentsOf: result)
        })
    }
    
    func isAccessDeniedError(_ error: Error) -> Bool {
        let statusCode = error.asResponseError?.statusCode
        
        return statusCode == HTTPStatusCode.notAuthorized.rawValue
    }
    
    var isAllMandatoryRequestsSucceeded: Bool {
        Request.allCases
            .filter(\.isMandatory)
            .allSatisfy { succeededRequests.contains($0) }
    }
}
