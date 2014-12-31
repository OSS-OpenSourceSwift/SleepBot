//
//  SleepEventViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 12/30/14.
//  Copyright (c) 2014 JMGSE. All rights reserved.
//

import UIKit
import HealthKit

enum SleepEventMode {
    case NotStarted
    case InBed
    case OutOfBed
    case Recorded
    
    func labelStrings() -> (String, String){
        switch self {
        case .NotStarted:
            return ("Tap to start sleeping", "Go to bed")
        case .InBed:
            return ("Ok, get in bed now.", "Wake up")
        case .OutOfBed:
            return ("It's a lovely morning!", "Record this nap")
        case .Recorded:
            return ("Ok, score recorded successfully", "")
        }
    }
    
}

class SleepEventViewController: UIViewController {

    var healthStore: HKHealthStore?
    
    var mode: SleepEventMode = SleepEventMode.NotStarted {
        didSet {
            let (labelText, buttonText) = mode.labelStrings()
            infoLabel.text = labelText
            infoButton.titleLabel?.text = buttonText
        }
    }
    
    var startTime: NSDate?
    var endTime: NSDate?
    
    var duration: NSTimeInterval? {
        if let st = startTime {
            return endTime?.timeIntervalSinceDate(st)
        } else {return nil}
    }
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    func recordSleepTimes() {
        let sleepType = HKCategoryType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)
        let inBedValue = HKCategoryValueSleepAnalysis.InBed.rawValue
        let sleepSample = HKCategorySample(type: sleepType, value: inBedValue, startDate: startTime, endDate: endTime)
        healthStore?.saveObject(sleepSample) { (Bool success, NSError error) -> Void in
            if (!success) {
                println(error)
            }
        }
    }
    

    @IBAction func update(sender: AnyObject) {
        switch mode {
        case .NotStarted:
            startTime = NSDate(timeIntervalSinceNow: 0)
            mode = .InBed
        case .InBed:
            endTime = NSDate(timeIntervalSinceNow: 0)
            mode = .OutOfBed
//            infoLabel.text = infoLabel.text! + "\nLasted: \(duration)"
        case .OutOfBed:
            recordSleepTimes()
            mode = .Recorded
        default:
            break
        }
    }

    

}
