//
//  ExcerciseSession.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class ExcerciseSession: Activity {
    
    private static var __totalDuration = Stats<Double>(name: "Total Ex. Sessions duration: ", value: 0)
    override class var totalDuration: Stats<Double> {
        get {
            return Self.__totalDuration
        }
    }
    
    private override init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        super.init(name: name, duration: duration, distance: nil, repetitions: nil)
    }
    
    convenience init(duration: Double) {
        self.init(name: "Session", duration: duration, distance: nil, repetitions: nil)
    }
    
}
