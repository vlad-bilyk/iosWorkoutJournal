//
//  Activity.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 01.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData


public class Activity {
    
    private static var _totalDuration = Stats(name: "Total duration", value: 0, units: .seconds)
    class var totalDuration: Stats {
        get {
            return Self._totalDuration
        }
    }
    
    private static var _totalDistance = Stats(name: "Total distance", value: 0, units: .metres)
    class var totalDistance: Stats {
        get {
            return Self._totalDistance
        }
    }
    
    private static var _totalRepetitions = Stats(name: "Total repetitions", value: 0, units: .numbers)
    class var totalRepetitions: Stats {
        get {
            return Self._totalRepetitions
        }
    }
     
    class var name: String {
        return "Activity"
    }
    
    class var imageName: String {
        return ""
    }
    
    var duration: Double?
    {
        willSet {
            if let prevDuration = self.duration {
                Self.totalDuration.value -= prevDuration
            }
        }
        didSet {
            if let _ = self.duration {
                Self.totalDuration.value += self.duration!
            }
        }
    }
    
    var distance: Double?
    {
        willSet {
            if let prevDistance = self.distance {
                Self.totalDistance.value -= prevDistance
            }
        }
        didSet {
            if let _ = self.distance {
                Self.totalDistance.value += self.distance!
            }
        }
    }
    
    var repetitions: Double?
    {
        willSet {
            if let prevRepetitions = self.repetitions {
                Self.totalRepetitions.value -= prevRepetitions
            }
        }
        didSet {
            if let _ = self.repetitions {
                Self.totalRepetitions.value += self.repetitions!
            }
        }
    }
    
    var details: String {
        var details = ""
        
        if let distance = self.distance {
            details += distance.kmString
        }
        
        if let duration = self.duration {
            if !details.isEmpty {
                details += " | "
            }
            details += duration.secondsString
        }
        
        if let reps = self.repetitions {
            if !details.isEmpty {
                details += " | "
            }
            details += String(Int(reps))
        }
        
        return details
    }
    
    lazy var entityName: String = {
        let name = NSStringFromClass(type(of: self)) + "Model"
        return name.components(separatedBy: ".").last!
    }()
    
    required init(duration: Double? = 0, distance: Double? = 0, repetitions: Double? = 0) {
        self.duration = duration
        self.distance = distance
        self.repetitions = repetitions

        if let _ = duration {
            Self.totalDuration.value += duration!
        }
        if let _ = distance {
            Self.totalDistance.value += distance!
        }
        if let _ = repetitions {
            Self.totalRepetitions.value += repetitions!
        }
    }
    
    func updateAchievements() {
        
    }
    
    func updateAchievementsAfterDeletion() {
        
    }
    
    func getAchievements() -> [Achievement] {
        return []
    }
    
    func removeStats() {
        if let _ = self.duration {
            Self.totalDuration.value = max(0, Self.totalDuration.value - self.duration!)
        }
        if let _ = self.distance {
            Self.totalDistance.value = max(0, Self.totalDistance.value - self.distance!)
        }
        if let _ = self.repetitions {
            Self.totalRepetitions.value = max(0, Self.totalRepetitions.value - self.repetitions!)
        }
    }
    
    func toManagedObject(context: NSManagedObjectContext) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context)!
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(self.duration, forKey: "duration")
        managedObject.setValue(self.distance, forKey: "distance")
        managedObject.setValue(self.repetitions, forKey: "repetitions")

        return managedObject
    }
    
    class func getStats() -> [Stats] {
        return [totalDuration, totalDistance, totalRepetitions]
    }
    
    class func updateCustomStats() {
        
    }
    
    static func getActivityType(byName: String) -> Activity.Type? {
        if byName == "Running" {
            return Running.self
        }
        else if byName == "Push-ups" {
            return PushUps.self
        }
        else if byName == "Pull-ups" {
            return PullUps.self
        }
        else if byName == "Plank" {
            return Plank.self
        }
        else if byName == "Excercise Session" {
            return ExcerciseSession.self
        }
        
        return nil
    }
    
}

// MARK: - Getters

extension Activity {
    
}

// MARK: - toString

extension Activity {
    
    func toString() -> String {
        var str =  "[ name: \(Self.name)"
        str += duration == nil ? "" : " | duration: \(String(self.duration! / 60)) min."
        str += distance == nil ? "" : " |  distance: \(String(self.distance! / 1000)) km"
        str += repetitions == nil ? "" : " | repetitions: \(String(self.repetitions!))"
        str += " ]"
        
        return str
    }
}
