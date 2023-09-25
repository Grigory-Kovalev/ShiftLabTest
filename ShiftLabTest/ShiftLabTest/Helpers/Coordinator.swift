//
//  Coordinator.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 24.09.2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    func showRegistretionScreen()
    func showMainScreen()
    func showModalScreen()
    func closeModule()
}

final class Coordinator {
    
    static let share = Coordinator()
    
    private var viewConrtollers = [UIViewController]()
    
    var rootViewController: UIViewController {
        get { self.viewConrtollers.first! }
        set {
            if viewConrtollers.isEmpty {
                viewConrtollers.insert(newValue, at: 0)
            }
        }
    }
    
    private var currentViewController : UIViewController {
        self.viewConrtollers.last!
    }
    
    
    
    func push(viewController: UIViewController, isFullScreen: Bool) {

        if isFullScreen == false {
            print("notFullScreen")
            self.currentViewController.present(viewController, animated: true, completion: nil)
        } else {
            print("fullScreen")
            self.currentViewController.modalPresentationStyle = .fullScreen
            viewController.modalPresentationStyle = .fullScreen
            self.currentViewController.present(viewController, animated: true, completion: nil)
        }
        
        self.viewConrtollers.append(viewController)
        print("")
        print("Выполнен переход на контроллер \(currentViewController)")
        print("Текущий стек:")
        viewConrtollers.map({ print("\($0)") })
    }
    
    func pop() {
        if viewConrtollers.count == 1 {
            print("Нельзя закрыть корневой экран")
        } else {
            print("")
            print("Закрыл \(currentViewController)")
            self.currentViewController.dismiss(animated: true)
            self.viewConrtollers.removeLast()
            print("Текущий стек:")
            viewConrtollers.map({ print("\($0)") })
        }
    }
}

extension Coordinator: CoordinatorProtocol {
    func closeModule() {
        self.pop()
    }
    
    func showRegistretionScreen() {
        let vc = RegistrationAssembly().createModule()
        self.push(viewController: vc, isFullScreen: true)
    }
    
    func showMainScreen() {
        let vc = MainScreenAssembly().createModule()
        self.push(viewController: vc, isFullScreen: true)
    }
    
    func showModalScreen() {
        let vc = WelcomeModalScreenAssembly().createModule()
        self.push(viewController: vc, isFullScreen: false)
    }
    
}
