//
//  WelcomeModalScreen.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

import UIKit

protocol WelcomeModalScreenViewControllerProtocol: AnyObject {
    func set(presenter: WelcomeModalScreenPresenter)
}

final class WelcomeModalScreenViewController: UIViewController {
    
    private enum Metrics {
        static let closeButtonTopOffset: CGFloat = 16
        static let closeButtonTrailingOffset: CGFloat = -16
        static let removeUserDataButtonBottomOffset: CGFloat = -32
    }
    
    // MARK: - Properties
    var presenter: WelcomeModalScreenPresenterProtocol?
    
    // MARK: - Subviews
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resource.WelcomeModalScreen.Texts.closeButton, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeUserDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resource.WelcomeModalScreen.Texts.removeUserDataButton, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(removeUserDataButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func removeUserDataButtonWasTapped(_ sender: UIButton) {
        self.presenter?.removeUserData()
        self.presenter?.closeModalScreen()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.set(viewController: self)
        setupUI()
        configureUI()
        configureLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentationController?.delegate = self
    }
    
    @objc private func closeButtonWasTapped(_ sender: UIButton) {
        self.presenter?.closeModalScreen()
    }
}

private extension WelcomeModalScreenViewController {
    // MARK: - Layout
    func setupUI() {
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metrics.closeButtonTopOffset),
            closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Metrics.closeButtonTrailingOffset)
        ])
        
        self.view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.view.addSubview(removeUserDataButton)
        NSLayoutConstraint.activate([
            removeUserDataButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            removeUserDataButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Metrics.removeUserDataButtonBottomOffset)
        ])
    }
    
    // MARK: - Configure
    func configureUI() {
        self.view.backgroundColor = .systemBackground
    }
    // MARK: - Private method
    func configureLabel() {
        let fullName = self.presenter?.getFullName()
        self.welcomeLabel.text = Resource.WelcomeModalScreen.Texts.welcomeLabel + ", " + "\(fullName!)!"
    }
}

// MARK: - WelcomeModalScreenViewControllerProtocol
extension WelcomeModalScreenViewController: WelcomeModalScreenViewControllerProtocol {
    func set(presenter: WelcomeModalScreenPresenter) {
        self.presenter = presenter
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension WelcomeModalScreenViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
}
