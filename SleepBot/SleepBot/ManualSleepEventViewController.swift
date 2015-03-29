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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let now = NSDate(timeIntervalSinceNow: 0)
        datePicker.date = now
        if startTime == nil {startTime = now}
        if endTime == nil {endTime = now}
        updateLabels()
    }
    
    // Actions
    
    func updateLabels()
    {
        // Use NSDateFormatter
        let format = NSDateFormatter()
        format.dateStyle = .MediumStyle
        format.timeStyle = .MediumStyle
        startLabel.text = format.stringFromDate(startTime!)
        endLabel.text = format.stringFromDate(endTime!)
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
    
    @IBAction func addSleepEvent(sender: AnyObject)
    {
        recordSleepTimes()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Table View Delegate
    
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        selectedIndex = TimeType(rawValue: indexPath.row)!
    }
}
