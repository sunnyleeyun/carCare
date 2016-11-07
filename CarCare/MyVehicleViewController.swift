//
//  MyVehicleViewController.swift
//  CarCare
//
//  Created by Andi Setiyadi on 10/10/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class MyVehicleViewController: UIViewController { //, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<AutoMaker> = AutoMaker.fetchRequest()
        request.predicate = NSPredicate(format: "make = 'Subaru'")
        
        do{
            let results = try managedObjectContext.fetch(request)
            let autoMaker = results.first
            print("AutoMaker: \(autoMaker?.make)")
        }
        catch{
            fatalError()
        }
        
        
    }
    
    @IBAction func homeAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
