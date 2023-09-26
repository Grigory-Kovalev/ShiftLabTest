//
//  AppCoordinator.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        var persistentStorageService: PersistentStorageService? = PersistentStorageService()
        let hasData = persistentStorageService?.hasData()
        
        if hasData! {
            showMainScreen()
        } else {
            showRegistrationScreen()
        }
        
        persistentStorageService = nil
    }
    
    private func showRegistrationScreen() {
        let registrationModule = RegistrationAssembly().createModule()
        
        window.rootViewController = registrationModule
        window.makeKeyAndVisible()
    }
    
    private func showMainScreen() {
        let mainScreenModule = MainScreenAssembly().createModule()
        
        window.rootViewController = mainScreenModule
        window.makeKeyAndVisible()
    }
}
