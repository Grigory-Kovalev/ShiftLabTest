//
//  MainScreenViewController.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 24.09.2023.
//

import UIKit

protocol MainScreenViewControllerProtocol: AnyObject {
    func refreshUICollectionView(data: [MainScreenModel])
    func welcomeButtonWasTapped()
}

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    let customView = MainScreenView()
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        customView.viewController = self
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getContest()
    }
    
}

// MARK: - MainScreenViewControllerProtocol
extension MainScreenViewController: MainScreenViewControllerProtocol {
    func welcomeButtonWasTapped() {
        self.presenter?.showModalScreen()
    }
    
    func refreshUICollectionView(data: [MainScreenModel]) {
        self.customView.dataArray = data
        self.customView.collectionView.reloadData()
    }
    
    
}
