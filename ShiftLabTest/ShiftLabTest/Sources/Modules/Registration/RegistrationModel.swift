//
//  RegistrationModel.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import Foundation

struct RegistrationModel {
    let firstName: String
    let lastName: String
    let birthday: Date
    var confirmPassword: String
    var password: String
}

enum ValidationResults {
    case invalidFirstName, invalidLastName, invalidBirthday, invalidPassword, invalidConfirmPassword
    case success

}


