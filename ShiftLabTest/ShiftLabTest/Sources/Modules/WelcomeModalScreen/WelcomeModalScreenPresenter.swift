//
//  WelcomeModalScreenPresenter.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

import Foundation

protocol WelcomeModalScreenPresenterProtocol {
    func closeModalScreen()
    func set(viewController: WelcomeModalScreenViewControllerProtocol)
    func getFullName() -> String
    func removeUserData()
}

final class WelcomeModalScreenPresenter {
    weak var viewController: WelcomeModalScreenViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
    weak var persistentStorageService: PersistentStorageServiceProtocol?
    
    init() {
        self.viewController?.set(presenter: self)
    }
}

extension WelcomeModalScreenPresenter: WelcomeModalScreenPresenterProtocol {
    func removeUserData() {
        self.persistentStorageService?.deleteAllData()
        self.coordinator?.closeModule()
        self.coordinator?.showRegistretionScreen()
    }
    
    func getFullName() -> String {
        self.persistentStorageService?.getUserName() ?? "Гость"
    }
    
    func set(viewController: WelcomeModalScreenViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func closeModalScreen() {
        coordinator?.closeModule()
    }
}
