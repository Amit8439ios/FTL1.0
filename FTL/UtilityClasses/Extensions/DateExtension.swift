//
//  DateExtension.swift
//  WeSolve
//
//  Created by Abhishek Agarwal on 12/05/19.
//  Copyright © 2019 Abhishek Agarwal. All rights reserved.
//

import Foundation
import UIKit

func getDateFromString(strDate: String, currentDate: String) -> String {
    print(strDate)
    
    let fromDate = Date(timeIntervalSince1970: Double(strDate)!)
    let date = Date(timeIntervalSince1970: Double(currentDate)!)
    print(date.offset(from: fromDate))
    return date.offset(from: fromDate)
}

// MARK: - Date Extension
extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }

    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func dayOfTheWeek() -> String? {
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]

        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components(.weekday, from: self) as NSDateComponents
        return weekdays[components.weekday - 1]
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return years(from: date)   > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago"  }
        if months(from: date)  > 0 { return months(from: date)  > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago" }
        if weeks(from: date)   > 0 { return weeks(from: date)   > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"  }
        if days(from: date)    > 0 { return days(from: date)    > 1 ? "\(days(from: date)) days ago"  : "\(days(from: date)) day ago"  }
        if hours(from: date)   > 0 { return hours(from: date)   > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"  }
        if minutes(from: date) > 0 { return minutes(from: date) > 1 ? "\(minutes(from: date)) mins ago" : "\(minutes(from: date)) min ago" }
        if seconds(from: date) > 0 { return "\(seconds(from: date)) secs ago" }
        return ""
    }
}

extension Date {
    
    func timestamp() -> String {
        return "\(self.timeIntervalSince1970)"
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func dateWithTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }

    func currentDateTimeStringFromDate(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }

    func dateStringFromDate(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func timeStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func dateLocalStringFromDate(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    func dateCurrentZoneFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    func timeStringWithDayFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        let weekDay = self.dayOfTheWeek()
        return "\(weekDay ?? "") \(dateFormatter.string(from: self))"
    }

    func timeWithMiliSecondStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func yearsFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func daysFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getFutureTime() -> (String,Int) {
        
        var secondsAgo = Int(self.timeIntervalSince(Date()))-18000
        if secondsAgo < 0 {
            secondsAgo *= (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            if secondsAgo < 2 {
                return ("just now",secondsAgo)
            } else {
                return ("\(secondsAgo) secs later",secondsAgo)
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1 {
                return ("\(min) min later",secondsAgo)
            } else {
                return ("\(min) mins later",secondsAgo)
            }
        } else if secondsAgo < day {
            let hour = secondsAgo/hour
            if hour == 1 {
                return ("\(hour) hr later",secondsAgo)
            } else {
                return ("\(hour) hrs later",secondsAgo)
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1 {
                return ("\(day) day later",secondsAgo)
            } else {
                return ("\(day) days later",secondsAgo)
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, hh:mm a"
            formatter.locale = Locale.current
            formatter.timeZone = NSTimeZone.local

            let strDate: String = formatter.string(from: self)
            return (strDate,secondsAgo)
        }
    }
    
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }

    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }

    func getYesterday() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }

    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }

    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    // This Month Start
    func getThisMonthStart() -> Date? {
        var components = Calendar.current.dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(identifier: "UTC")
        return Calendar.current.date(from: components)!
    }

    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.timeZone = TimeZone(identifier: "UTC")
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }

    // Last Month Start
    func getLastMonthStart() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.timeZone = .current
        components.month -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }

    // Last Month End
    func getLastMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.timeZone = .current
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }

}
extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
