//
//  BaseCoordintator.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation
import MAFoundation

open class BaseCoordinator {
    private enum LocalConstants {
        static let applicationCoordinator = "MovieApp.ApplicationCoordinator"
    }
    
    /// Роутер координатора
    public let router: Routable

    /// Родительский координатор
    private weak var parentCoordinator: BaseCoordinator?
    
    /// Дочерние координаторы
    private var childCoordinators: [BaseCoordinator] = []
    
    /// Свойство позволяет понять как показан координатор, из коробки или нет
    private var isStartingWithCoordinator = false
    
    /// Свойство позволяет считать кол-во юнитов в координаторе
    public private(set) var countUnits: Int = 0
    
    public init(router: Routable, parent: BaseCoordinator?) {
        self.router = router
        self.router.subscribe(self)

        guard parent != nil || String(describing: self) == LocalConstants.applicationCoordinator else {
            fatalError("Nil parent can only be set for ApplicationCoordinator")
        }

        parentCoordinator = parent
        parent?.addDependency(self)
    }

    
}

// MARK: - LifeCycleListener

extension BaseCoordinator: LifeCycleListener {
    public func increment() {
        if countUnits == 0 {
            parentCoordinator?.addDependency(self)
        }
        countUnits += 1
    }
    
    public func decrement() {
        countUnits -= 1
        checkCountUnits()
    }
    
    public func startNotify() {
        if let rootCoordinator = routerAsTheRoot(router) {
            let hierarchy = hierarchyToRoot
            // Prune every child in root coordinator
            rootCoordinator.removeAll()

            // restore current coordinators chain if root is in coordinator's hierarchy
            if let rootChild = hierarchy.first {
                rootCoordinator.addDependency(rootChild)
            }
        }

        countUnits = 1
    }
    
    public func dismissNotify(event: ApplicationRouter.RouterEvent) {
        switch event {
        case .uikit: removeAll()
        case .userInitiative:
            if let modalDescendant = modallyPresentedDescandant,
               modalDescendant.router !== self.router {
                if childCoordinators.contains(where: { $0 === modalDescendant }) {
                    removeDependency(modalDescendant)
                } else {
                    fatalError("""
                    Illegal attempt to dismiss coordinator without dismissing a child coordinator first.
                    Coordinator: \(self)
                    ModalDescendant: \(modalDescendant)
                    """)
                }

                return
            }

            // when we dismiss a flow from a child coordinator started by another coordinator
            if let coordinatorToDelete = hierarchyToRoot.first?.parentCoordinator {
                coordinatorToDelete.parentCoordinator?.removeDependency(coordinatorToDelete)
            } else if let rootParent = routerAsTheRoot(router)?.parentCoordinator, rootParent.childCoordinators.contains(where: { $0 === self }) {
                rootParent.removeDependency(self)
            } else {
                Logger.error("Unable to dismiss coordinator: \(self)")
            }
        }
    }
    
    public func toRootNofity(in router: Routable) {
        if let parent = routerAsTheRoot(router), parent !== self {
            parent.toRootNofity(in: router)
        } else {
            popToRootHierarchyProcessing()
        }
    }
    
    public func isListener(for coordinator: BaseCoordinator) -> Bool {
        self === coordinator
    }
    
    // MARK: - Private

    private func addDependency(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }

        isStartingWithCoordinator = countUnits == 0
        childCoordinators.append(coordinator)
    }

    private func removeDependency(_ coordinator: BaseCoordinator) {
        childCoordinators.removeAll { $0 === coordinator }

        if childCoordinators.isEmpty, countUnits == 0 {
            parentCoordinator?.removeDependency(self)
        }
    }

    private func removeAll() {
        childCoordinators.removeAll()
    }

    private func popToRootHierarchyProcessing() {
        if isStartingWithCoordinator, let first = childCoordinators.first {
            removeAll()
            childCoordinators = [first]
            first.popToRootHierarchyProcessing()
            countUnits = 0
        } else {
            removeAll()
            countUnits = 1
        }
    }
    
    private func checkCountUnits() {
        assert(countUnits >= 0, "countUnits: \(countUnits) что то пошло не так, исправь!")
        if countUnits == 0 {
            parentCoordinator?.removeDependency(self)
        }
    }
    
    /**
     Hierarchy of coordinators from current to root not including root.
     This is required to restore coordinators chain in `startNotify()`

     Empty if self is root or there is no root at all.
     */
    private var hierarchyToRoot: [BaseCoordinator] {
        guard let rootCoordinator = routerAsTheRoot(router), rootCoordinator !== self else {
            return []
        }

        var hierarchy = [BaseCoordinator]()

        var currentCoordinator = self

        while currentCoordinator !== rootCoordinator, currentCoordinator.parentCoordinator != nil {
            hierarchy.insert(currentCoordinator, at: 0)

            if let parent = currentCoordinator.parentCoordinator {
                currentCoordinator = parent
            }
        }

        return hierarchy
    }
    
    /// Node tree of coordinator and its children.
    private var nodeTree: Node<BaseCoordinator> {
        if childCoordinators.isEmpty {
            return Node(value: self)
        } else {
            return Node(value: self, children: childCoordinators.map { $0.nodeTree })
        }
    }

    /// The first modally presented descendant coordinator
    private var modallyPresentedDescandant: BaseCoordinator? {
        return nodeTree.first { node in
            node.value.router.isModallyPresented
        }?.value
    }
}



private extension BaseCoordinator {
    /// Finds the root coordinator of navigation controller
    func routerAsTheRoot(_ router: Routable) -> BaseCoordinator? {
        if parentCoordinator?.router !== router {
            return self
        }
        return parentCoordinator?.routerAsTheRoot(router)
    }

    var parentName: String {
        if let parent = parentCoordinator {
            return String(describing: parent.currentName)
        }
        return "Что то рутовое"
    }

    var currentName: String {
        return "\(Unmanaged.passUnretained(self).toOpaque()) " + String(describing: Self.self)
    }
}
