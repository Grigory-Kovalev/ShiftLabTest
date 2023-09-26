//
//  ViewController.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 21.09.2023.
//

import UIKit

protocol RegistrationViewControllerProtocol: AnyObject {
    func showAlert(with validationResult: ValidationResults)
    
    func firstSecureButtonTapped(_ sender: UIButton)
    func secondSecureButtonTapped(_ sender: UIButton)
    func confirmButtonTapped(_ sender: UIButton)
    func cancelButtonTapped()
    
    func registerButtonTapped()
}

final class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = RegistrationView()
    var textData: AppData.RegisterScreenDataModel!
    var presenter: RegistrationPresenterProtocol?
    
    private let animationDuration = 0.3
    private var initialTextFieldsStackViewY = 0.0
    
    @objc private var firstSecureIsButtonTapped = false
    @objc private var secondSecureIsButtonTapped = false
    
    private var confirmButtonIsTapped = false
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = customView
        customView.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
    }
    
    // MARK: - Private method
    private func createAlert(with validationResult: ValidationResults) {
        var title = Resource.RegisterScreen.AlertMessages.errorTitle
        if validationResult == .info {
            title = Resource.RegisterScreen.AlertMessages.infoTitle
        }
        let message = Resource.RegisterScreen.AlertMessages.errorMessage(for: validationResult)

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - RegistrationViewControllerProtocol
extension RegistrationViewController: RegistrationViewControllerProtocol {
    func firstSecureButtonTapped(_ buttonSender: UIButton) {
        firstSecureIsButtonTapped.toggle()
        
        if let textField = self.customView.textFieldsStackView.arrangedSubviews[3].subviews.compactMap({ $0 as? UITextField }).first {
            textField.isSecureTextEntry = !firstSecureIsButtonTapped
        }
        
        if firstSecureIsButtonTapped {
            buttonSender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.notSecureTextField), for: .normal)
        } else {
            buttonSender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.secureTextField), for: .normal)
        }
    }
    
    func secondSecureButtonTapped(_ sender: UIButton) {
        secondSecureIsButtonTapped.toggle()
        
        if let textField = self.customView.textFieldsStackView.arrangedSubviews[4].subviews.compactMap({ $0 as? UITextField }).first {
            textField.isSecureTextEntry = !secondSecureIsButtonTapped
        }
        
        if secondSecureIsButtonTapped {
            sender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.notSecureTextField), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.secureTextField), for: .normal)
        }
    }
    
    func confirmButtonTapped(_ sender: UIButton) {
        confirmButtonIsTapped.toggle()
        
        if !confirmButtonIsTapped {
            sender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.confirmButton), for: .normal)
            self.customView.registerButtonDisable()
        } else {
            sender.setImage(UIImage(systemName: Resource.RegisterScreen.Images.confirmButtonFill), for: .normal)
            self.customView.registerButtonEnable()
        }
    }
    
    func cancelButtonTapped() {
        self.customView.endEditing(true)
    }
    
    func registerButtonTapped() {
        guard let firstName = (self.customView.viewWithTag(Resource.RegisterScreen.TextFieldConfigs.Tags.firstName) as? UITextField)?.text else { return }
        guard let lastName = (self.customView.viewWithTag(Resource.RegisterScreen.TextFieldConfigs.Tags.lastName) as? UITextField)?.text else { return }
        guard let password = (self.customView.viewWithTag(Resource.RegisterScreen.TextFieldConfigs.Tags.password) as? UITextField)?.text else { return }
        guard let confirmPassword = (self.customView.viewWithTag(Resource.RegisterScreen.TextFieldConfigs.Tags.confirmPassword) as? UITextField)?.text else { return }
        let birthday = self.customView.birthdayDatePicker.date
        
        self.presenter?.getData(firstName: firstName, lastName: lastName, birthday: birthday, password: password, confirmPassword: confirmPassword)
    }
    
    func showAlert(with validationResult: ValidationResults) {
        createAlert(with: validationResult)
    }
}

//MARK: - SetupKeyboardNotifications
private extension RegistrationViewController {
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let screenHeight = UIScreen.main.bounds.height
            let textFieldsStackViewBottom = screenHeight - customView.textFieldsStackView.frame.maxY
            
            if textFieldsStackViewBottom < keyboardFrame.height {
                let yOffset = max(keyboardFrame.height - textFieldsStackViewBottom, 0)
                UIView.animate(withDuration: animationDuration) {
                    self.customView.frame.origin.y = -yOffset
                }
                self.initialTextFieldsStackViewY = yOffset
                customView.cancelButton.isHidden = false
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: animationDuration) {
            self.customView.frame.origin.y = 0
        }
        self.customView.cancelButton.isHidden = true
        self.customView.endEditing(true)
    }
}
