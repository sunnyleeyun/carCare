//
//  ViewController.swift
//  CarCare
//
//  Created by Andi Setiyadi on 10/10/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var addVehicleButton: UIButton!
    
    
    // MARK: - Properties
    
    var managedObjectContext: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myVehicleController = segue.destination as! MyVehicleViewController
        myVehicleController.managedObjectContext = managedObjectContext
    }
}

