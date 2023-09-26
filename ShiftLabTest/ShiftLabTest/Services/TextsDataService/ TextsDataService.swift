//
//   TextsDataService.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 26.09.2023.
//

import Foundation

struct TextsDataService {
    
    static let share = TextsDataService()
    
    private var appData: AppData!
    
    init() {
        guard let decodedAppData = decodeAppDataFromFile() else {
            fatalError("Не удалось загрузить данные из JSON-файла.")
        }
        self.appData = decodedAppData
    }
    
    private func decodeAppDataFromFile() -> AppData? {
        if let filePath = Bundle.main.path(forResource: "TextsData", ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let appData = try decoder.decode(AppData.self, from: data)
                return appData
            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("Файл TextsData.json не найден.")
            return nil
        }
    }
    
    func getRegisterScreenData() -> AppData.RegisterScreenDataModel {
        return appData.registerScreen
    }
    
    func getMainScreenData() -> AppData.MainScreenDataModel {
        return appData.mainScreen
    }
    
    func getWelcomeModalScreenData() -> AppData.WelcomeModalScreenDataModel {
        return appData.welcomeModalScreen
    }
}
