//
//  SleepEventsTableViewController.swift
//  SleepBot
//
//  Created by JJ Garzella on 7/7/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import UIKit
import HealthKit

class SleepEventsTableViewController: UITableViewController {

    var healthStore: HKHealthStore?
    var sleepTimes = [SleepEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let hs = healthStore {
            
            // make query
            
            
            let pred = HKQuery.predicateForCategorySamplesWithOperatorType(.EqualToPredicateOperatorType, value: HKCategoryValueSleepAnalysis.InBed.rawValue)
            
            let tomorrow = NSDate(timeIntervalSinceNow: 0).dateByAddingTimeInterval(60*60*24)
            let todayAtMidnight = tomorrow.dateByRoundingDownToComponents(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay)
            let beginningOfThisYear = tomorrow.dateByRoundingDownToComponents(.CalendarUnitYear)
            
            let q = HKSampleQuery(sampleType: nil, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: nil)
            
            let query = HKSampleQuery(sampleType: SLEEP_TYPE, predicate: pred, limit: HKObjectQueryNoLimit, sortDescriptors: [AnyObject]())
                { query, results, error in
                
            }
            
        } else {
            let e = NSException(name: "Bad health store",
                              reason: "The healthStore property has not been set",
                            userInfo: nil)
            e.raise()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
