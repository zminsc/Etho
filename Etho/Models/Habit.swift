//
//  Habit.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation
import SwiftUI

struct Habit: Identifiable {
    var name: String
    var color: Color
    
    var startDate = Date()
    var isChecked = [false]
    var consecutiveMissesAllowed: Int
    
    func getStreak(at date: Date) -> Int {
        let idxOffset = Calendar.current.dateComponents([.day], from: startDate, to: date).day!
        guard isChecked.count > idxOffset else { return 0 }
        
        var length = isChecked[idxOffset] ? 1 : 0
        var consecutiveMisses = 0
        
        for i in (0..<idxOffset).reversed() {
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
    
    var streak: Int {
        guard !isChecked.isEmpty else { return 0 }
        
        var length = isChecked[isChecked.count - 1] ? 1 : 0
        var consecutiveMisses = 0
        
        for i in (0..<(isChecked.count - 1)).reversed() {
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
    
    var id: String { name }
}
