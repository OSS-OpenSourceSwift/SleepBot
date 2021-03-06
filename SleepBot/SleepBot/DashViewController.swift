//
//  DashViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 12/30/14.
//  Copyright (c) 2014 JMGSE. All rights reserved.
//

import UIKit
import HealthKit

let SLEEP_TYPE = HKCategoryType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)


class DashViewController: UIViewController {

    var healthStore: HKHealthStore?

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if (HKHealthStore.isHealthDataAvailable()) {
            healthStore = HKHealthStore()
            let sleepTypeSet = NSSet(object: SLEEP_TYPE)
            
            healthStore?.requestAuthorizationToShareTypes(sleepTypeSet, readTypes: sleepTypeSet) { (Bool success, NSError error) -> Void in
                
                if (!success) {
                    println(error)
                }
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? SleepEventHandler {
            destVC.healthStore = healthStore
        }
    }
    

}
