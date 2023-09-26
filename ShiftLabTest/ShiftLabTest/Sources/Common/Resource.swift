//
//  Resource.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import UIKit

enum Resource {
    enum RegisterScreen {
        enum Colors {
            static let background = UIColor(named: "Background")
            static let customGreen = UIColor(red: 22/255, green: 156/255, blue: 137/255, alpha: 1)
            static let customGray = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
            static let textFieldBackground = UIColor(named: "TextFieldBackground")
            static let textFieldStroke = UIColor(named: "TextFieldStroke")?.cgColor
            static let textFieldImage = UIColor(named: "TextFieldImage")
            static let textFieldPlaceholder = UIColor.gray //UIColor(named: "TextFieldPlaceholder")
        }
        
        enum Texts {
            static let titleText = "Sing Up"
            static let subTitleText = "Register to get started"
            static let birthdayLabel = "Ваша дата рождения"
            static let policyLabel = "By registering, you are agreeing with our\nTerms of Use and Privacy Policy"
            static let registerButton = "Зарегистрироваться"
            static let bottomView = "Already have an account? Log in"
            static let cancelButton = "hide"
            static let policyLabelLeadingUnderline = "Terms of Use"
            static let policyLabelTrailingUnderline = "Privacy Policy"
            static let bottomViewUnderline = "Log in"
        }
        
        enum AlertMessages {
            static let errorTitle = "Ошибка"
            
            static func errorMessage(for validationResult: ValidationResults) -> String {
                switch validationResult {
                case .invalidFirstName:
                    return "Имя должно содержать более двух символов и не содержать числа."
                case .invalidLastName:
                    return "Фамилия должна содержать более двух символов и не содержать числа."
                case .invalidBirthday:
                    return "Минимальный допустимый возраст - 16 лет."
                case .invalidPassword:
                    return "Пароль должен содержать более 5 символов и включать заглавные буквы и цифры."
                case .invalidConfirmPassword:
                    return "Пароли не совпадают."
                case .success:
                    return ""
                }
            }
        }

        
        enum Images {
            static let confirmButton = "square"
            static let confirmButtonFill = "checkmark.square.fill"
            static let secureTextField = "eye.slash"
            static let notSecureTextField = "eye"
        }
        
        enum Fonts {
            static let titleFont = UIFont.systemFont(ofSize: 40, weight: .bold)
            static let subTitleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
            static let policyLabel = UIFont.systemFont(ofSize: 16)
            static let bottomView = UIFont.systemFont(ofSize: 16)
        }
        
        enum TextFieldConfigs {
            enum Tags {
                static let firstName = 10
                static let lastName = 11
                static let password = 12
                static let confirmPassword = 13
            }
            
            enum Placeholders {
                static let firstName = "Введите ваше имя"
                static let lastName = "Введите вашу фамилию"
                static let password = "Введите пароль"
                static let confirmPassword = "Подтвердите пароль"
            }
            
            enum Images {
                static let firstName = "person.circle"
                static let lastName = "person.circle"
                static let password = "lock"
                static let confirmPassword = "lock"
            }
            
            enum ImageSizes {
                static let firstName: (width: CGFloat, height: CGFloat) = (width: 25, height: 25)
                static let lastName: (width: CGFloat, height: CGFloat) = (width: 25, height: 25)
                static let password: (width: CGFloat, height: CGFloat) = (width: 25, height: 25)
                static let confirmPassword: (width: CGFloat, height: CGFloat) = (width: 25, height: 25)
            }
        }
    }
    
    enum MainScreen {
        enum Fonts {
            static let titleLabelCell = UIFont.systemFont(ofSize: 16, weight: .bold)
            static let dateRangeLabelCell = UIFont.systemFont(ofSize: 14)
        }
        
        enum Colors {
            static let titleLabelTextCell = UIColor.black
            static let dateRangeLabelTextCell = UIColor.gray
            static let cellBorderColorCell = UIColor.lightGray
        }
        
        enum Texts {
            static let welcomeButton = "Приветствие"
        }
    }
}
