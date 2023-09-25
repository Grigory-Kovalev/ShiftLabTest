//
//  ModalScreenAssembly.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

import UIKit

protocol WelcomeModalScreenAssemblyProtocol {
    func createModule() -> UIViewController
}

final class WelcomeModalScreenAssembly: MainScreenAssemblyProtocol {
    
    func createModule() -> UIViewController {
        let viewController = WelcomeModalScreenViewController()
        let presenter = WelcomeModalScreenPresenter()
        let persistentStorageService = PersistentStorageService.share
        let coordinator = Coordinator.share
        coordinator.rootViewController = viewController
        
        // Установка зависимостей
                
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        presenter.persistentStorageService = persistentStorageService
        
        
        return viewController
    }

}
