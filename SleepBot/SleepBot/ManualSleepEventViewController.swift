//
//  ManualSleepEventViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 2/12/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import UIKit
import HealthKit



private enum TimeType: Int {
    case InBed = 0, OutOfBed
}

class ManualSleepEventViewController: UITableViewController, SleepEventHandler, UITableViewDelegate  {

    var event: SleepEvent!
    var healthStore: HKHealthStore? {
        didSet {
            event = SleepEvent(healthStore: healthStore!)
            
        }
    }
    
    // Properties and declarations
    
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    
    private var selectedIndex = TimeType.InBed;
    
    // View Lifecycle
        
    override func viewDidAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let now = NSDate(timeIntervalSinceNow: 0)
        datePicker.date = now
        if event.startTime == nil {event.startTime = now}
        if event.endTime == nil {event.endTime = now}
        updateLabels()
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)

    }
    
    deinit {
        event.resetDefaults()
    }
    
    // Actions
    
    func updateLabels()
    {
        // Use NSDateFormatter
        let format = NSDateFormatter()
        format.dateStyle = .ShortStyle
        format.timeStyle = .ShortStyle
        startLabel.text = format.stringFromDate(event.startTime!)
        endLabel.text = format.stringFromDate(event.endTime!)
    }
    
    @IBAction func updateTime(sender: UIDatePicker)
    {
        switch selectedIndex {
        case .InBed:
            event.startTime = sender.date
        case .OutOfBed:
            event.endTime = sender.date
        }
        if let st = event.startTime {
            switch event.endTime?.isEarlierThan(st) {
            case (let invalid) where invalid == true || invalid == nil:
                event.endTime = event.startTime
            default:
                break
            }
        }
        
        updateLabels()
        
    }
    
    @IBAction func addSleepEvent(sender: AnyObject)
    {
        event.save()
        event.resetDefaults()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = TimeType(rawValue: indexPath.row)!
    }
}

// IGNORE FOR NOW

//// This class and protocol are for the view that is contianed in the container view
//private protocol TableViewSelectedIndexDelegate: class {
//    var selectedIndex: TimeType { get set }
//}
//
//class ManualSleepEventContainedTableViewController: UITableViewController {
//    
//    private weak var delegate: TableViewSelectedIndexDelegate?
//    
//    override func tableView(tableView: UITableView,
//        didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        delegate?.selectedIndex = TimeType(rawValue: indexPath.row)!
//    }
//}
