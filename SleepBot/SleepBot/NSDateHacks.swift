//
//  NSDateHacks.swift
//  SleepBot
//
//  Created by JJ Garzella on 1/1/15.
//  Copyright (c) 2015 JMGSE. All rights reserved.
//

import Foundation

public enum DateClipInterval {
    case ThirtyMinutes
    case OneHour
    
    typealias DateClippingBlock = (NSDateComponents) -> NSDateComponents
    
    private func clipBlock() -> DateClippingBlock
    {
        switch self {
        case .ThirtyMinutes:
            return { (components: NSDateComponents) -> NSDateComponents in
                if (components.minute < 30) {
                    components.minute = 0
                } else if (components.minute >= 30) {
                    components.minute = 0
                    components.hour += 1
                }
                return components
            }
        case .OneHour:
            return { (components: NSDateComponents) -> NSDateComponents in
                if (components.minute < 15) {
                    components.minute = 0
                } else if ((15 <= components.minute && components.minute < 45)) {
                    components.minute = 30
                } else if (45 <= components.minute) {
                    components.minute = 0
                    components.hour += 1
                }
                return components;
            }
        }
    }
}

extension NSDate {
    // MARK - clipping
    
    public class func closestIntervalToDate(date: NSDate, interval: DateClipInterval) -> NSDate?
    {
        let cal = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute
        let componentsOfDate = cal.components(flags, fromDate: date)
        let newComponents = interval.clipBlock()(componentsOfDate)
        return cal.dateFromComponents(newComponents)
    }
    
    // MARK - description between two times
    
    public func descriptionBetweenDate(date: NSDate) -> String
    {
        let cal = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute
        let components = cal.components(flags, fromDate: self, toDate: date, options: NSCalendarOptions.allZeros)
        var descBetween: String = ""
        if (components.day > 0) {descBetween += "Days: \(components.day)\n"}
        if (components.hour > 0) {descBetween += "Hours: \(components.hour)\n"}
        descBetween += "Minutes: \(components.minute)"
        return descBetween
    }

    // MARK - comparison
    public func isEarlierThan(other: NSDate) -> Bool
    {
        switch compare(other) {
        case .OrderedAscending:
            return true
        default: // NSOrderedSame or NSOrderedDescending
            return false
        }
    }
    public func isLaterThan(other: NSDate) -> Bool
    {
        switch compare(other) {
        case .OrderedDescending:
            return true
        default:
            return false
        }
    }

}

