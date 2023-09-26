//
//  WebViewAssembly.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 26.09.2023.
//

import UIKit
protocol WebViewAssemblyProtocol {
    func createModule() -> UIViewController
}

final class WebViewAssembly: WebViewAssemblyProtocol {
    var url: URL!
    init(url: URL) {
        self.url = url
    }
    
    func createModule() -> UIViewController {
        let viewController = WebViewController()
        viewController.website = url
        let navVC = UINavigationController(rootViewController: viewController)
        let presenter = WebViewPresenter()
        let coordinator = Coordinator.share
        
        // Установка зависимостей
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        
        
        return navVC
    }

}
