//
//  MyVehicleViewController.swift
//  CarCare
//
//  Created by Andi Setiyadi on 10/10/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class MyVehicleViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showVehicle()
        let carService = CarService(managedObjectContext: managedObjectContext)
        carService.showVehicle()
    }
    
        
    @IBAction func homeAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
