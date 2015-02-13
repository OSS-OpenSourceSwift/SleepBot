//
//  TouchSleepEventViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 2/12/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import UIKit
import HealthKit

enum SleepEventMode {
    case NotStarted
    case InBed
    case OutOfBed
    case Recorded
    
    func labelStrings() -> (String, String)
    {
        switch self {
        case .NotStarted:
            return ("Tap to start sleeping", "Go to bed")
        case .InBed:
            return ("Ok, get in bed now.", "Wake up")
        case .OutOfBed:
            return ("It's a lovely morning!", "Record this nap")
        case .Recorded:
            return ("Ok, nap recorded successfully", "")
        }
    }
    
}

class TouchSleepEventViewController: SleepEventViewController {

    var mode: SleepEventMode = SleepEventMode.NotStarted {
        willSet {
            let (labelText, buttonText) = newValue.labelStrings()
            infoLabel.text = labelText
            infoButton.setTitle(buttonText, forState: UIControlState.Normal)
        }
    }
    
    var inProgress: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("IN_PROGRESS")
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "IN_PROGRESS")
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var statTextView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if inProgress {
            // In this case, the start time has already been entered
            mode = .InBed
        } else {
            mode = .NotStarted
        }
    }
    
    @IBAction func update(sender: AnyObject)
    {
        println("Update sent by: \(sender)")
        switch mode {
        case .NotStarted:
            startTime = NSDate(timeIntervalSinceNow: 0)
            mode = .InBed
            inProgress = true
        case .InBed:
            endTime = NSDate(timeIntervalSinceNow: 0)
            mode = .OutOfBed
            inProgress = false
            statTextView.text = startTime?.descriptionBetweenDate(endTime!)
            println(startTime)
            println(endTime)
        case .OutOfBed:
            recordSleepTimes()
            mode = .Recorded
            startTime = nil
            endTime = nil
        default:
            break
        }
    }
    
    deinit {
        if (!inProgress) {
            startTime = nil
            endTime = nil
        }
    }
}
