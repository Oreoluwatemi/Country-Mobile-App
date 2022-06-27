//
//  CoreDataService.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-04.
//

import Foundation
import CoreData

class CoreDataService{
    static var Shared = CoreDataService()
    
    func insertCountryDataIntoStorage(name : String, p : Int, ca : String, f : Data, cu : String, t : String){
        let newCountry = CountryCoreModel(context: persistentContainer.viewContext);
        newCountry.name = name;
        newCountry.population = Int32(p);
        newCountry.flag = f;
        newCountry.currencies = cu;
        newCountry.capital = ca;
        newCountry.timzone = t;
        
        saveContext()
        
    }
    
    func getAllCountriesDataFromStorage() -> [CountryCoreModel] {
        
        var result = [CountryCoreModel]()
        let countryFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryCoreModel")
        do {
            result = try (persistentContainer.viewContext.fetch(countryFetch) as? [CountryCoreModel])!
            
          print( result.count)
        }catch {
            print (error)
            
        }
        return result
        
    }
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "ProjectApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
