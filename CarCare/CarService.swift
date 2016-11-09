//
//  CarService.swift
//  CarCare
//
//  Created by Andi Setiyadi on 10/10/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import Foundation
import CoreData

class CarService {
    
    internal var managedObjectContext: NSManagedObjectContext!
    
    internal init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    
    deinit {
        self.managedObjectContext = nil
    }
    

    func loadVehicleData() {
        //Sample API
        //let url = URL(string: "http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&year=1995&api_key=wyu4qhu7wm97kvk86ph9bs3n")
        
        //let privateContext = CoreDataStack().persistentContainer.newBackgroundContext()
        
        let url = URL(string: "http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&year=1995&api_key=xyru8r7x7qfp4qka6c5hmpv4")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            let httpResponse = response as! HTTPURLResponse
            
            if httpResponse.statusCode == 200{
                print(data)
                self.managedObjectContext.performAndWait({
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        let jsonArray = jsonResult.value(forKey: "makes") as! NSArray
                        
                        for json in jsonArray{
                            let carData = json as! [String: AnyObject]
                            guard let makeName = carData["name"] else {return}
                            
                            //let autoMaker = AutoMaker(context: privateContext)
                            let autoMaker = AutoMaker(context: self.managedObjectContext)
                            autoMaker.make = makeName as? String
                            
                            let autoModels = autoMaker.autoModel?.mutableCopy() as! NSMutableSet
                            
                            guard let arrModelNames = carData["models"] as? NSArray else {return}
                            for modelName in arrModelNames{
                                let jsonModel = modelName as! [String: AnyObject]
                                let modelName = jsonModel["name"] as? String
                                
                                //let autoModel = AutoModel(context: privateContext)
                                let autoModel = AutoModel(context: self.managedObjectContext)
                                autoModel.model = modelName
                                
                                let autoYears = autoModel.autoYear?.mutableCopy() as! NSMutableSet
                                
                                guard let arrModelYears = jsonModel["years"] as? NSArray else {return}
                                for modelYear in arrModelYears{
                                    let jsonYear = modelYear as![String: AnyObject]
                                    let year = jsonYear["year"] as? NSNumber
                                    
                                    //let autoYear = AutoYear(context: privateContext)
                                    let autoYear = AutoYear(context: self.managedObjectContext)
                                    autoYear.year = (year?.int16Value)!
                                    autoYears.add(autoYear)
                                }
                                //Set AutoYear into AutoModel for CoreData
                                autoModel.autoYear = autoYears.copy() as? NSSet
                                autoModels.add(autoModel)
                            }
                            //Set the AutoModel into AutoMaker for CoreData
                            autoMaker.autoModel = autoModels.copy() as? NSSet
                        }
                        try self.managedObjectContext.save()
                        //try self.managedObjectContext.save()
                    }
                    catch let error as NSError{
                        print("Error in parsing JSON data: \(error.localizedDescription)")
                    }
                    
                })
                self.showVehicle()
            }
        }
        task.resume()
    }
    
    func showVehicle() {
        let request: NSFetchRequest<AutoMaker> = AutoMaker.fetchRequest()
        request.predicate = NSPredicate(format: "make = 'Subaru'")
        
        do {
            let results = try managedObjectContext.fetch(request)
            let autoMaker = results.first
            print("Automaker: \(autoMaker?.make)")
        }
        catch {
            fatalError()
        }
    }

}

