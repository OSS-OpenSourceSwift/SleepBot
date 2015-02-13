//
//  ManualSleepEventViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 2/12/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import UIKit

class ManualSleepEventViewController: SleepEventViewController, UITableViewDelegate  {

    
    // Properties and declarations
    
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    enum TimeType: Int {
        case InBed = 0, OutOfBed
    }
    
    var selectedIndex = TimeType.InBed;
    
    // View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let now = NSDate(timeIntervalSinceNow: 0)
        datePicker.date = now
        startTime = now
        endTime = now
        updateLabels()
    }
    
    // Actions
    
    func updateLabels()
    {
        // Use NSDateFormatter
    }
    
    @IBAction func updateTime(sender: UIDatePicker)
    {
        switch selectedIndex {
        case .InBed:
            startTime = sender.date
        case .OutOfBed:
            endTime = sender.date
        }
        if let st = startTime {
            switch endTime?.isEarlierThan(st) {
            case (let invalid) where invalid == true || invalid == nil:
                endTime = startTime
            default:
                break
            }
        }
        
        updateLabels()
        
    }
    
    @IBAction func dismiss(sender: AnyObject)
    {
        recordSleepTimes()
        presentingViewController?.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
    // Table View Delegate
    
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        selectedIndex = TimeType(rawValue: indexPath.row)!
    }
}
