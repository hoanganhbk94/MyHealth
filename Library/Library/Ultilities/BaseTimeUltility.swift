//
//  BaseTimeUltility.swift
//  Library
//
//  Created by Duong Le Bac on 2/23/18.
//  Copyright © 2018 Eastgate Software. All rights reserved.
//

import Foundation

open class BaseTimeUtility {
    struct DateFormats {
        static let date_format               = "yyyy-MM-dd"
        static let time_format               = "HH:mm"
        static let day_name_format           = "EEEE"
        static let day_short_name_format     = "EEE"
        static let date_full_format          = "dd MMM yyyy"
        static let date_time_format          = "yyyy-MM-dd HH:mm:ss"
        static let display_date_time_format  = "HH:mm yyyy-MM-dd"
        static let date_all_format           = "EEEE, yyyy-MM-dd"
        static let date_chat_header_format   = "dd MMMM yyyy"
        static let month_year_format         = "MMMM yyyy"
        
        static let trip_confirm_format       = "HH:mm a  dd/MM/yyyy"
        static let day_off_format            = "dd MMM yyyy  -  HH:mm a"
        static let date_time_detail_format   = "HH:mm a EEE, dd MMM yyyy"
    }
    
    // MARK: - String -> String
    
    open static func getTimeFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = DateFormats.time_format
            let dateStr = dateFormatter.string(from: date)
            return dateStr
        }
        return ""
    }
    
    open static func getDateFullFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = DateFormats.date_full_format
            let dateStr = dateFormatter.string(from: date)
            return dateStr
        }
        return ""
    }
    
    open static func getAroundDate(from date1: String, to date2: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let date1 = dateFormatter.date(from: date1), let date2 = dateFormatter.date(from: date2) {
            dateFormatter.dateFormat = DateFormats.time_format
            let dateStr1 = dateFormatter.string(from: date1)
            dateFormatter.dateFormat = DateFormats.time_format
            let dateStr2 = dateFormatter.string(from: date2)
            dateFormatter.dateFormat = DateFormats.day_name_format
            let dateStr3 = dateFormatter.string(from: date1)
            dateFormatter.dateFormat = DateFormats.date_full_format
            let dateStr4 = dateFormatter.string(from: date1)
            return "\(dateStr1) - \(dateStr2) \(dateStr3), \(dateStr4)"
        }
        return ""
    }
    
    open static func getTripConfirmDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let date1 = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = DateFormats.trip_confirm_format
            let dateStr = dateFormatter.string(from: date1)
            return dateStr
        }
        return ""
    }
    
    open static func getDayOffDate(from dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let date1 = dateFormatter.date(from: dateStr) {
            dateFormatter.dateFormat = DateFormats.day_off_format
            let dateStr = dateFormatter.string(from: date1)
            return dateStr
        }
        return ""
    }
    
    open static func getDayOffDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.day_off_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getFullDetailDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_detail_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getDayShortNameOfDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.day_short_name_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func minutesBetween(start: String, end: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let start = dateFormatter.date(from: start), let end = dateFormatter.date(from: end), let minute = Calendar.current.dateComponents([.minute], from: start, to: end).minute {
            return minute
        }
        return 0
    }
    
    open static func sendToServerFormatDate(from dateStr: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.day_off_format
        if let str = dateStr, let date = dateFormatter.date(from: str) {
            dateFormatter.dateFormat = DateFormats.date_time_format
            let dateStr = dateFormatter.string(from: date)
            return dateStr
        }
        return ""
    }
    
    open static func sendToServerFormatDate(from date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        if let sendDate = date {
            let dateStr = dateFormatter.string(from: sendDate)
            return dateStr
        }
        return ""
    }
    
    open static func getQuickBookingTimes(from date: Date?, times: [Int]) -> [String] {
        var arrTimes: [String] = []
        for time in times {
            if let nextDate = Calendar.current.date(byAdding: .minute, value: time, to: date!) {
                let dateStr = self.getTimeFormat(date: nextDate)
                arrTimes.append(dateStr)
            }
        }
        return arrTimes
    }
    
    open static func getQuickBookingDateTimes(from date: Date?, times: [Int]) -> [Date] {
        var arrTimes: [Date] = []
        for time in times {
            if let nextDate = Calendar.current.date(byAdding: .minute, value: time, to: date!) {
                arrTimes.append(nextDate)
            }
        }
        return arrTimes
    }
    
    open static func getWeekDays() -> [String] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .flatMap {calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today)}
        var arrDays: [String] = []
        for day in days {
            let dayStr = self.getDayShortNameOfDate(from: day)
            arrDays.append(dayStr)
        }
        return arrDays
    }
    
    // MARK: - Date -> String
    
    open static func getDateFormatted(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getCurrentTimeFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.time_format
        let dateStr = dateFormatter.string(from: Date())
        return dateStr
    }
    
    open static func getCurrentDateTimeFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        let dateStr = dateFormatter.string(from: Date())
        return dateStr
    }
    
    open static func getDateTimeFormat(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getTimeFormat(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.time_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getMonthYearFormat(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.month_year_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getDateAllFormat(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_all_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getDisplayDateTimeFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.display_date_time_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getDisplayTimeFormatted(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.time_format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getTripConfirmFormatted(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.trip_confirm_format
        if let currentDate = date {
            let dateStr = dateFormatter.string(from: currentDate)
            return dateStr
        }
        return ""
    }
    
    open static func getTimeStampFormatted(timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.time_format
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    open static func getRoundDate(minuteDistance: CGFloat, from date: Date) -> Date? {
        var dateComponents = Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute], from: date)
        if let minutes = dateComponents.minute {
            var minutesFloat = CGFloat(minutes)
            let minuteUnit = ceil(minutesFloat / minuteDistance)
            minutesFloat = minuteUnit * minuteDistance
            dateComponents.minute = Int(minutesFloat)
            let currentDate = Calendar.current.date(from: dateComponents)
            return currentDate
        }
        return nil
    }
    
    open static func getRoundDateStr(minuteDistance: CGFloat, from date: Date?) -> (String, Date) {
        if let currentDate = date, let convertDate = self.getRoundDate(minuteDistance: minuteDistance, from: currentDate) {
            let dateStr = self.getTripConfirmFormatted(date: convertDate)
            return (dateStr, convertDate)
        }
        return ("", Date())
    }
    
    // MARK: - String -> Date
    open static func getTimeFormatFromString(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.time_format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    open static func getDateFormatFromString(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    open static func getDateTimeFormatFromString(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.date_time_format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    open static func getTripDateFormatFromString(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.trip_confirm_format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    open static func getEarlyDateYearAgo(currentDate: Date) -> Date? {
        guard let earlyDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)  else {
            return nil
        }
        return earlyDate
    }
    
    open static func getNextDays(currentDate: Date, days: Int) -> Date? {
        guard let nextDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate)  else {
            return nil
        }
        return nextDate
    }
    
    open static func getTomorrowDate(currentDate: Date) -> Date? {
        guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)  else {
            return nil
        }
        return tomorrowDate
    }
    
    open static func getDistanceDate(minutes: Int, currentDate: Date?) -> Date? {
        guard let curDate = currentDate, let distanceDate = Calendar.current.date(byAdding: .minute, value: minutes, to: curDate)  else {
            return nil
        }
        return distanceDate
    }
    
    open static func getStartTimeOfDay(from date: Date) -> Date {
        var canlendar = Calendar.current
        canlendar.timeZone = TimeZone.current
        let startTime = canlendar.startOfDay(for: date)
        return startTime
    }
    
    open static func getEndTimeOfDay(from date: Date) -> Date? {
        let startTime = self.getStartTimeOfDay(from: date)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let dateAtEnd = Calendar.current.date(byAdding: components, to: startTime)
        return dateAtEnd
    }
    
    open static func getDistanceTimeOfDay() -> TimeInterval {
        let currentDate = Date()
        let startTime = self.getStartTimeOfDay(from: currentDate)
        if let endTime = self.getEndTimeOfDay(from: currentDate) {
            let timeInterval = endTime.timeIntervalSince(startTime)
            return timeInterval
        }
        return 0
    }
}
