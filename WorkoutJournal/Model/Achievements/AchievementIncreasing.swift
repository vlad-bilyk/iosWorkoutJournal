//
//  AchievementIncreasing.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 16.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class AchievementIncreasing: Achievement {
   
    var name: String
    var description: String
    var valueToAchieve: Double
    var currentValue: Double {
        didSet {
            if self.currentValue >= self.valueToAchieve {
                self.achieved = true
            }
            else {
                self.achieved = false
            }
        }
    }
    var achieved: Bool = false
    
    init(name: String, description: String = "", valueToAchieve: Double, currentValue: Double = 0) {
        self.name = name
        self.description = description
        self.valueToAchieve = valueToAchieve
        self.currentValue = currentValue
    }
    
    func setCurrentValue(_ value: Double) {
        self.currentValue = value
       }
       
    func updateAfterDeletion(deletedValue: Double) {
        self.currentValue = deletedValue
    }
    
}
