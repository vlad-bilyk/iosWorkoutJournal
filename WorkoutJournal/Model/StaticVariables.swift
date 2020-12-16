//
//  StaticVariables.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class StaticVariables {
    
    static let defaultActivityTypes = [Running.self, PushUps.self, PullUps.self, Plank.self, ExcerciseSession.self]
    
    static let defaultActivityNames = StaticVariables.defaultActivityTypes.map({
        $0.name
    })
    
    static func getTotalTimeSpentOnActivities() -> Stats {
        return Stats(name: "Total time spent excercising", value: Running.totalDuration.value + Plank.totalDuration.value + ExcerciseSession.totalDuration.value, units: .seconds)
    }
    
    static func datesFromSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    static let monthsNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    static func dateComponentsToString(_ componenets: [Int]) -> String {
        let day = componenets[0]
        let monthString = Self.monthsNames[componenets[1] - 1]
        let year = componenets[2]
        return "\(day) \(monthString), \(year)"
    }
    
}
