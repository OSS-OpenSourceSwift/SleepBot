//
//  SleepEvent.swift
//  SleepBot
//
//  Created by JJ Garzella on 7/8/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import Foundation

class SleepEvent {
    
    init() {}
    init(startTime: NSDate, endTime: NSDate) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var startTime: NSDate!
    var endTime: NSDate!
    var duration: NSTimeInterval? {
        if let st = startTime {
            return endTime?.timeIntervalSinceDate(st)
        } else {return nil}
    }
}