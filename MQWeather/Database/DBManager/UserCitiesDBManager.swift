//
//  UserCitiesDBManager.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//

import Foundation
import CoreData

class UserCitiesDBManager: DBManager {
    var subContext:NSManagedObjectContext!
    static let shared = UserCitiesDBManager.init()
    
    //MARK: - Init
    override init(){
        super.init()
        subContext = DBManager.sharedDB.persistentContainer.viewContext
    }
    
    //MARK: - managedObjectContextDidSave
       @objc func managedObjectContextDidSave(notification: NSNotification) {
           let notificationCenter = NotificationCenter.default
           notificationCenter.removeObserver(self)
           
           DispatchQueue.main.async { () -> Void in
               self.subContext.mergeChanges(fromContextDidSave: notification as Notification)
               DBManager.sharedDB.saveContext()
           }
       }
    //MARK:- saveContext
    func saveChildContext() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextDidSave(notification:)),
                                       name: NSNotification.Name.NSManagedObjectContextDidSave,
                                       object: subContext)
        self.saveContext()
        
    }
    
    //MARK: - saveContext
    override func saveContext() {
        if subContext.hasChanges {
            do {
                try subContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
    //MARK:- Save
    func save(_ latitude: Double?, longitude: Double?, name: String?) {
        var entity: UserCities!
        
        let lastRecord = self.getLastRecord()
        var id: Int64 = 0
        if let obj = lastRecord {
            id = obj.id
        }
        id += 1
        do {
            let request = UserCities.request()
            if let cityName = name {
                request.predicate = NSPredicate.init(format: "name = %@", cityName)
            }
            
            let results  = try self.subContext.fetch(request)
            if(results.count > 0){
                entity = results[0]
            }else{
                entity = NSEntityDescription.insertNewObject(forEntityName: "UserCities", into: self.subContext) as? UserCities
            }
            entity.save(id,latitude: latitude, longitude: longitude, name: name)
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        self.saveContext()
    }
    func getLastRecord() -> UserCities? {
        
        let request = UserCities.request()
        var allEntry = [UserCities]()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        do {
            allEntry = try self.subContext.fetch(request)
        }
        catch let error as NSError{
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        if allEntry.count > 0 {
            return allEntry[0]
        }
        return nil
        
    }
    
    
    func getAllcities() -> [UserCities] {
        var entity = [UserCities]()
        let request = UserCities.request()
        do {
            entity = try self.subContext.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return entity
    }
    
    func removeCity(_ id: Int64) {
           let request = UserCities.request()
           let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
           do {
            let allRecords = try subContext.fetch(request)
               
               for obj in allRecords {
                   subContext.delete(obj)
               }
           } catch let error as NSError {
               print("Fetch failed: \(error.localizedDescription)")
           }
           self.saveChildContext()
           
       }

    func remove() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserCities")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try DBManager.sharedDB.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: subContext)
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
    }
}


