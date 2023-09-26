//
//  TextsDataModel.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 26.09.2023.
//

import Foundation

struct AppData: Codable {
    let registerScreen: RegisterScreenDataModel
    let mainScreen: MainScreenDataModel
    let welcomeModalScreen: WelcomeModalScreenDataModel
    
    struct RegisterScreenDataModel: Codable {
        let texts: Texts
        let alertMessages: AlertMessagesTexts
        let placeholders: Placeholders
        
        struct Texts: Codable {
            let titleText: String
            let subTitleText: String
            let birthdayLabel: String
            let policyLabel: String
            let registerButton: String
            let bottomView: String
            let cancelButton: String
            let policyLabelLeadingUnderline: String
            let policyLabelTrailingUnderline: String
            let bottomViewUnderline: String
        }
        
        struct AlertMessagesTexts: Codable {
            let errorTitle: String
            let infoTitle: String
            let invalidFirstName: String
            let invalidLastName: String
            let invalidBirthday: String
            let invalidPassword: String
            let invalidConfirmPassword: String
            let info: String
        }
        
        struct Placeholders: Codable {
            let firstName: String
            let lastName: String
            let password: String
            let confirmPassword: String
        }
    }
    
    struct MainScreenDataModel: Codable {
        let texts: Texts
        
        struct Texts: Codable {
            let welcomeButton: String
        }
    }
    
    struct WelcomeModalScreenDataModel: Codable {
        let texts: Texts
        
        struct Texts: Codable {
            let closeButton: String
            let removeUserDataButton: String
            let welcomeLabel: String
        }
    }
}



