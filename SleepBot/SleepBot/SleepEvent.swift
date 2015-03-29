//
//  SleepEvent.swift
//  SleepBot
//
//  Created by JJ Garzella on 3/29/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import UIKit
import HealthKit


class SleepEvent {
    
    weak let healthStore: HKHealthStore
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    var startTime: NSDate? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("START_TIME") as? NSDate
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "START_TIME")
        }
    }
    var endTime: NSDate? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("END_TIME") as? NSDate
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "END_TIME")
        }
    }
    
    var duration: NSTimeInterval? {
        if let st = startTime {
            return endTime?.timeIntervalSinceDate(st)
        } else {return nil}
    }
    
    func save()
    {
        let sleepType = HKCategoryType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)
        let inBedValue = HKCategoryValueSleepAnalysis.InBed.rawValue
        let sleepSample = HKCategorySample(type: sleepType, value: inBedValue, startDate: startTime, endDate: endTime)
        healthStore.saveObject(sleepSample) { (Bool success, NSError error) -> Void in
            if (!success) {
                println(error)
            }
        }
    }
}
