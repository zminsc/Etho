//
//  Habit.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation
import SwiftUI

struct Habit {
    var name: String
    var color: Color
    
    var startDate = Date()
    var isChecked = [false]
    var consecutiveMissesAllowed: Int
    
    var streak: Int {
        var length = 0
        var consecutiveMisses = 0
        
        for i in (0..<isChecked.count).reversed() {
            if isChecked[i] {
                length += 1
                consecutiveMisses = 0
            } else if consecutiveMisses >= consecutiveMissesAllowed {
                break
            } else {
                consecutiveMisses += 1
            }
        }
        
        return length
    }
}
