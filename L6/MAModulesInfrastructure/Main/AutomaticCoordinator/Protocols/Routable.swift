//
//  Routable.swift
//  MAModulesInfrastructure
//
//  Created by Dan Gorb on 20.09.2023.
//

import Foundation

public protocol Routable: AnyObject {
    ///  Push модуля
    /// - Parameters:
    ///   - module: модуль для операции
    ///   - transition: анимация перехода
    ///   - hideBottomBar: флаг скрыть/показать tabbar
    ///   - animated: флаг анимации
    ///   - completion: вызываемый блок после выполнения
    func pushModule(
        _ module: Presentable,
        transition: Transition?,
        hideBottomBar: Bool,
        animated: Bool,
        completion: (() -> Void)?
    )

    /// Установить root модуль
    /// - Parameters:
    ///   - module: модуль для установки
    ///   - transition: анимация перехода
    ///   - hideNavigationBar: флаг скрыть/показать navigationBar
    ///   - animated: флаг анимации
    func setRootModule(
        _ module: Presentable,
        transition: Transition?,
        hideNavigationBar: Bool,
        animated: Bool
    )

    /// Pop модуля
    /// - Parameters:
    ///   - transition: анимация перехода
    ///   - animated: флаг анимации
    ///   - completion: вызываемый блок после выполнения
    func popModule(transition: Transition?, animated: Bool, completion: (() -> Void)?)

    /// PopToRoot модуля, сбрасывает все текущие флоу до начального
    /// - Parameters:
    ///   - animated: флаг анимации
    ///   - completion: вызываемый блок после выполнения
    func popToRootModule(animated: Bool, completion: (() -> Void)?)

    func popModules(numberOfModules: Int, transition: Transition?, animated: Bool, completion: (() -> Void)?)

    /// Презентация модуля модально
    /// - Parameters:
    ///   - module: модулья для презентации
    ///   - animated: флаг анимации
    ///   - presentationStyle: стиль презентации
    ///   - transitionStyle: стиль перехода
    ///   - isModalInPresentation: Запрет на закрытие экрана свайпом вниз. Если `false` то свайп будет доступен
    ///   - completion: вызываемый блок после выполнения
    func presentModule(
        _ module: Presentable,
        animated: Bool,
        presentationStyle: ModalPresentationStyle,
        transitionStyle: ModalTransitionStyle,
        isModalInPresentation: Bool,
        completion: (() -> Void)?
    )

    /// Dismiss последнего модального модуля
    /// - Parameters:
    ///   - animated: флаг анимации
    ///   - completion: вызываемый блок после выполнения
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    /// Одновременный dismiss всех модальных модулей в stack
    /// - Parameters:
    ///   - animated: флаг анимации
    ///   - completion: вызываемый блок после выполнения
    func dismissToRoot(animated: Bool, completion: (() -> Void)?)

    /// Dismiss N последних модальных модулей
    /// - Parameters:
    ///   - numberOfModulesToDismiss: колличество модулей для dismiss
    ///   - completion: вызываемый блок после выполнения
    func dismissPresentedModules(numberOfModulesToDismiss: UInt, animated: Bool, completion: (() -> Void)?) throws

    /// Pop/dismiss модуля на основе проверки навигации
    /// - Parameters:
    ///   - animated: флаг анимации
    ///   - supportedActions: доступные действия закрытия
    ///   - transitionIfCan: анимация перехода, если возможно
    ///   - completion: вызываемый блок после выполнения
    func closeModule(animated: Bool, supportedActions: CloseModuleAction, transitionIfCan: Transition?, completion: (() -> Void)?)

    /// Pop/dismiss модуля на основе проверки навигации
    /// - Parameters:
    ///   - module: модулья для презентации
    ///   - coordinator: координатор которому принадлежит модуль
    ///   - completion: вызываемый блок после выполнения
    func removeFromStack(
        _ module: Presentable,
        of coordinator: BaseCoordinator,
        completion: (() -> Void)?
    )

    /// Подписать на изменения сущность для контроля жизненного цикла
    /// - Parameter listener: слушатель
    func subscribe(_ listener: LifeCycleListener)

    /// Проверяет является ли модуль доследним в стеке навигации
    /// - Parameter module: Presentable
    func isLast(module: Presentable) -> Bool

    /// Проверяет является ли модуль видимым на экране.
    func isVisible(_ module: Presentable) -> Bool

    var isModallyPresented: Bool { get }
}

public extension Routable {
    func presentModule(
        _ module: Presentable,
        animated: Bool = true,
        presentationStyle: ModalPresentationStyle = .overFullScreen,
        transitionStyle: ModalTransitionStyle = .coverVertical,
        isModalInPresentation: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        presentModule(
            module,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            isModalInPresentation: isModalInPresentation,
            completion: completion
        )
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismissModule(animated: animated, completion: completion)
    }

    func popToRootModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        popToRootModule(animated: animated, completion: completion)
    }

    func pushModule(
        _ module: Presentable,
        transition: Transition? = nil,
        hideBottomBar: Bool = false,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        pushModule(module, transition: transition, hideBottomBar: hideBottomBar, animated: animated, completion: completion)
    }

    func popModule(
        transition: Transition? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        popModule(transition: transition, animated: animated, completion: completion)
    }

    func setRootModule(
        _ module: Presentable,
        transition: Transition? = nil,
        hideNavigationBar: Bool = true,
        animated: Bool = true
    ) {
        setRootModule(
            module,
            transition: transition,
            hideNavigationBar: hideNavigationBar,
            animated: animated
        )
    }

    func closeModule(
        animated: Bool = true,
        supportedActions: CloseModuleAction = .all,
        transitionIfCan: Transition? = nil,
        completion: (() -> Void)? = nil
    ) {
        closeModule(
            animated: animated,
            supportedActions: supportedActions,
            transitionIfCan: transitionIfCan,
            completion: completion
        )
    }

    func removeFromStack(
        _ module: Presentable,
        of coordinator: BaseCoordinator,
        completion: (() -> Void)? = nil
    ) {
        removeFromStack(module, of: coordinator, completion: completion)
    }
}

