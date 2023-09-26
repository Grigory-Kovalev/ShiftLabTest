//
//  PersistentStorageService.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 23.09.2023.
//

import CoreData
import UIKit

protocol PersistentStorageServiceProtocol: AnyObject {
    func saveData(of model: RegistrationModel)
    func deleteAllData()
    func hasData() -> Bool
    func getUserName() -> String
}

final class PersistentStorageService: PersistentStorageServiceProtocol {
    static let share = PersistentStorageService()
    
    func getUserName() -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }

        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserModel")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            guard let user = results?.first else {
                print("Данные пользователя не найдены")
                return ""
            }
            
            if let userFirstName = user.value(forKey: "firstName") as? String, let userLastName = user.value(forKey: "lastName") as? String {
                return userFirstName + " " + userLastName
            } else {
                return ""
            }
        } catch {
            print("Ошибка при получении имени пользователя: \(error)")
            return ""
        }
    }

    
    func saveData(of model: RegistrationModel) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "UserModel", in: context) else {
            print("no  entity")
            return
        }
        
        let newObject = NSManagedObject(entity: entity, insertInto: context)
        
        newObject.setValue(model.firstName, forKey: "firstName")
        newObject.setValue(model.lastName, forKey: "lastName")
        newObject.setValue(model.birthday, forKey: "birthday")
        newObject.setValue(model.password, forKey: "password")
        newObject.setValue(model.confirmPassword, forKey: "confirmPassword")
        
        do {
            try context.save()
            print("Данные сохранены в Core Data.")
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        let entityNames = persistentContainer.managedObjectModel.entities.map { $0.name ?? "" }
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
            } catch {
                print("Ошибка при удалении объектов сущности \(entityName): \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении контекста: \(error)")
        }
        print("Все данные удалены")
    }
    
    func hasData() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }

        let context = appDelegate.persistentContainer.viewContext

    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserModel")

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Ошибка при проверке наличия данных: \(error)")
            return false
        }
    }
}
