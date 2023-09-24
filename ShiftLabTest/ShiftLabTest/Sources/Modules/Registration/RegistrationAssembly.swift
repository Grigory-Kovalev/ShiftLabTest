//
//  RegistrationAssembly.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import Foundation

import UIKit

protocol RegistrationAssemblyProtocol {
    func createModule() -> UIViewController
}

final class RegistrationAssembly: RegistrationAssemblyProtocol {
    //let networkManager = NetworkService()
    
    func createModule() -> UIViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let persistentStorageService = PersistentStorageService()
        
        // Установка зависимостей
                
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.persistentStorageService = persistentStorageService
        
        //persistentStorageService.deleteAllData()
        
        return viewController
    }

}
