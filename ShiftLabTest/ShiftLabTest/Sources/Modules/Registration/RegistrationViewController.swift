//
//  ViewController.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 21.09.2023.
//

import UIKit

protocol RegistrationViewControllerProtocol: AnyObject {
    func showAlert(with validationResult: ValidationResults)
    func showMainScreen()
    
    func firstSecureButtonTapped(_ sender: UIButton)
    func secondSecureButtonTapped(_ sender: UIButton)
    func confirmButtonTapped(_ sender: UIButton)
    func cancelButtonTapped()
    
    func registerButtonTapped()
}

final class RegistrationViewController: UIViewController {
    
    let customView = RegistrationView()
    var presenter: RegistrationPresenterProtocol?
    
    private var initialTextFieldsStackViewY = 0.0
    
    @objc private var firstSecureIsButtonTapped = false
    @objc private var secondSecureIsButtonTapped = false
    
    private var confirmButtonIsTapped = false
    
    override func loadView() {
        super.loadView()
        customView.viewController = self
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
    }
    
    private func createAlert(with validationResult: ValidationResults) {
        let title = "Ошибка"
        var message = ""
        
        switch validationResult {
        case .invalidFirstName:
            message = "Имя должно содержать больше двух символов и не содержать цифр!"
        case .invalidLastName:
            message = "Фамилия должна содержать больше двух символов и не содержать цифр!"
        case .invalidBirthday:
            message = "Ваш возраст не может быть меньше 12 лет!"
        case .invalidPassword:
            message = "Пароль должен содержать более 5 символов и включать заглавные буквы и цифры!"
        case .invalidConfirmPassword:
            message = "Пароли не совпадают!"
        case .success:
            break
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegistrationViewController: RegistrationViewControllerProtocol {
    func firstSecureButtonTapped(_ buttonSender: UIButton) {
        firstSecureIsButtonTapped.toggle()
        
        if let textField = self.customView.textFieldsStackView.arrangedSubviews[3].subviews.compactMap({ $0 as? UITextField }).first {
            textField.isSecureTextEntry = !firstSecureIsButtonTapped
        }
        
        if firstSecureIsButtonTapped {
            buttonSender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            buttonSender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    func secondSecureButtonTapped(_ sender: UIButton) {
        secondSecureIsButtonTapped.toggle()
        
        if let textField = self.customView.textFieldsStackView.arrangedSubviews[4].subviews.compactMap({ $0 as? UITextField }).first {
            textField.isSecureTextEntry = !secondSecureIsButtonTapped
        }
        
        if secondSecureIsButtonTapped {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    func confirmButtonTapped(_ sender: UIButton) {
        confirmButtonIsTapped.toggle()
        
        if !confirmButtonIsTapped {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            self.customView.registerButton.backgroundColor = Resource.RegisterScreen.Colors.customGray
            self.customView.registerButton.isEnabled = false
        } else {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            self.customView.registerButton.backgroundColor = Resource.RegisterScreen.Colors.customGreen
            self.customView.registerButton.isEnabled = true
        }
    }
    
    func cancelButtonTapped() {
        self.customView.endEditing(true)
    }
    
    func registerButtonTapped() {
        guard let firstName = (self.customView.viewWithTag(10) as? UITextField)?.text else { return }
        guard let lastName = (self.customView.viewWithTag(11) as? UITextField)?.text else { return }
        guard let password = (self.customView.viewWithTag(12) as? UITextField)?.text else { return }
        guard let confirmPassword = (self.customView.viewWithTag(13) as? UITextField)?.text else { return }
        let birthday = self.customView.birthdayDatePicker.date
        
        let model = RegistrationModel(firstName: firstName, lastName: lastName, birthday: birthday, confirmPassword: password, password: confirmPassword)
        
        //self.viewController?.passData(with: model)
        self.presenter?.getData(with: model)
    }
    
    func showMainScreen() {
        print("show main screen")
        //self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true)
    }
    
    func showAlert(with validationResult: ValidationResults) {
        createAlert(with: validationResult)
    }
    
    
}

//MARK: - setupKeyboardNotifications
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
                UIView.animate(withDuration: RegistrationView.Metrics.animationDuration) {
                    self.customView.frame.origin.y = -yOffset // Установить координату Y корневой вью с учетом yOffset
                }
                self.initialTextFieldsStackViewY = yOffset
                customView.cancelButton.isHidden = false
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: RegistrationView.Metrics.animationDuration) {
            self.customView.frame.origin.y = 0
        }
        self.customView.cancelButton.isHidden = true
        self.customView.endEditing(true)
    }
}
