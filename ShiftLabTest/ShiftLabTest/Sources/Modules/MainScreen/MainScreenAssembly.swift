//
//  MainScreenAssembly.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 24.09.2023.
//

import UIKit

protocol MainScreenAssemblyProtocol {
    func createModule() -> UIViewController
}

final class MainScreenAssembly: MainScreenAssemblyProtocol {
    
    func createModule() -> UIViewController {
        let viewController = MainScreenViewController()
        let presenter = MainScreenPresenter()
        let coordinator = Coordinator.share
        coordinator.rootViewController = viewController
        let networkService = NetworkService()
        
        // Установка зависимостей
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        presenter.networkService = networkService
        
        
        return viewController
    }

}
