//
//  RegistrationAssembly.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import UIKit

protocol RegistrationAssemblyProtocol {
    func createModule() -> UIViewController
}

final class RegistrationAssembly: RegistrationAssemblyProtocol {
    
    func createModule() -> UIViewController {
        let persistentStorageService = PersistentStorageService.share
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let coordinator = Coordinator.share
        
        // Установка зависимостей
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        presenter.persistentStorageService = persistentStorageService
        coordinator.rootViewController = viewController
            
        return viewController
    }

}
