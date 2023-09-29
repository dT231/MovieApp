//
//  ApplicationRouter.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation
import UIKit
import MAUIKit
/// Сущность реализующая маршрутизацию
open class ApplicationRouter: NSObject {
    /// Тип эвента передаваемого в слушателя
    public enum RouterEvent {
        case uikit
        case userInitiative
    }

    public enum NavigationError: Error {
        case numberOfDismissCallsExceeds
        case cannotFindLastPresented
        case invalidNumberOfDismissingModules
    }

    private weak var rootController: SystemNavigationController?
    private var popTransition: Transition?
    private var pushTransition: Transition?
    private let windowHierarchyHelper: WindowHierarchyHelping
    private var listeners: [WeakReference<LifeCycleListener>] = []

    public init(
        rootController: SystemNavigationController?,
        windowHierarchyHelper: WindowHierarchyHelping = WindowHierarchyHelper(windowHelper: UIApplication.shared)
    ) {
        self.rootController = rootController
        self.windowHierarchyHelper = windowHierarchyHelper

        super.init()

        self.rootController?.delegate = self
        self.rootController?.popToRootHandler = { [weak self] in
            guard let self = self else {
                return
            }

            self.lastListener?.toRootNofity(in: self)
        }
    }
}
