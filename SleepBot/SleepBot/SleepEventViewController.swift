//
//  SleepEventViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 12/30/14.
//  Copyright (c) 2014 JMGSE. All rights reserved.
//

import UIKit
import HealthKit

//enum SleepEventMode {
//    case NotStarted
//    case InBed
//    case OutOfBed
//    case Recorded
//    
//    func labelStrings() -> (String, String)
//    {
//        switch self {
//        case .NotStarted:
//            return ("Tap to start sleeping", "Go to bed")
//        case .InBed:
//            return ("Ok, get in bed now.", "Wake up")
//        case .OutOfBed:
//            return ("It's a lovely morning!", "Record this nap")
//        case .Recorded:
//            return ("Ok, nap recorded successfully", "")
//        }
//    }
//    
//}

class SleepEventViewController: UIViewController {

    var healthStore: HKHealthStore?
    
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

    func recordSleepTimes()
    {
        let sleepType = HKCategoryType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)
        let inBedValue = HKCategoryValueSleepAnalysis.InBed.rawValue
        let sleepSample = HKCategorySample(type: sleepType, value: inBedValue, startDate: startTime, endDate: endTime)
        healthStore?.saveObject(sleepSample) { (Bool success, NSError error) -> Void in
            if (!success) {
                println(error)
            }
        }
    }

}
