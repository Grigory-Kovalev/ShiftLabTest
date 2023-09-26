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
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let persistentStorageService = PersistentStorageService.share
        let coordinator = Coordinator.share
        coordinator.rootViewController = viewController
        let textsDataService = TextsDataService.share
        
        // Установка зависимостей
        viewController.presenter = presenter
        viewController.textData = textsDataService.getRegisterScreenData()
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        presenter.persistentStorageService = persistentStorageService
            
        return viewController
    }

}
