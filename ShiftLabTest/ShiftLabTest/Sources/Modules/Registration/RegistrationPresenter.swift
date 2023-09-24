//
//  RegistrationPresenter.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import Foundation
import UIKit

protocol RegistrationPresenterProtocol: AnyObject {
    func validationCheck(with model: RegistrationModel)
    func getData(with model: RegistrationModel)
    
}

final class RegistrationPresenter {
    var viewController: RegistrationViewControllerProtocol?
    var model: RegistrationModel?
    var persistentStorageService: PersistentStorageServiceProtocol?

    
}

//MARK: - RegistrationPresenterProtocol
extension RegistrationPresenter: RegistrationPresenterProtocol {
    func getData(with model: RegistrationModel) {
        self.model = model
        validationCheck(with: model)
    }
    
    func validationCheck(with model: RegistrationModel) {
        let firstName = model.firstName
        let lastName = model.lastName
        let birthday = model.birthday
        let password = model.password
        let confirmPassword = model.confirmPassword
        
        let calendar = Calendar.current
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -12
        
        guard let twelveYearsAgo = calendar.date(byAdding: dateComponents, to: currentDate) else { return }
        
        guard firstName.count > 2 && !firstName.contains(where: { $0.isNumber }) else {
            self.viewController?.showAlert(with: .invalidFirstName)
            return
        }
        guard lastName.count > 2 && !lastName.contains(where: { $0.isNumber }) else {
            self.viewController?.showAlert(with: .invalidLastName)
            return
        }
        guard birthday < twelveYearsAgo else {
            self.viewController?.showAlert(with: .invalidBirthday)
            return
        }
        guard password.count >= 5 && password.contains(where: { $0.isNumber }) && password.contains(where: { $0.isUppercase }) else {
            self.viewController?.showAlert(with: .invalidPassword)
            return
        }
        guard confirmPassword == password else {
            self.viewController?.showAlert(with: .invalidConfirmPassword)
        return
        }
        self.persistentStorageService?.saveData(of: model)
        self.viewController?.showMainScreen()
    }
}
