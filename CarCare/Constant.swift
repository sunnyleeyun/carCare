//
//  Constant.swift
//  CarCare
//
//  Created by Andi Setiyadi on 10/10/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    static let SETUP_FIRST_CAR = "Add your first car"
    
    struct SceneType {
        static let MY_VEHICLES = "myVehicles"
    }
    
    struct SegueIdentifier {
        static let MY_VEHICLES = "segueMyVehicles"
        static let ADD_VEHICLE = "segueAddVehicle"
        static let EDIT_VEHICLE = "segueEditVehicle"
    }
    
    struct ColorTheme {
        static let MY_VEHICLES = UIColor(red: 234/255.0, green: 167/255.0, blue: 46/255.0, alpha: 1.0)
    }
}
