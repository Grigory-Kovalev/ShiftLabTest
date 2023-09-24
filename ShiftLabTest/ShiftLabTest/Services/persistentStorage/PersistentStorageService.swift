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
}

final class PersistentStorageService: PersistentStorageServiceProtocol {
    func saveData(of model: RegistrationModel) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        // Создаем новую сущность
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
        
        // Сохраняем изменения в контексте
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
        
        // Создание запроса на удаление для каждой сущности
        let entityNames = persistentContainer.managedObjectModel.entities.map { $0.name ?? "" }
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                // Выполнение запроса на удаление
                try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
            } catch {
                print("Ошибка при удалении объектов сущности \(entityName): \(error)")
            }
        }
        
        // Сохранение изменений
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении контекста: \(error)")
        }
        print("Все данные удалены")
    }
}
