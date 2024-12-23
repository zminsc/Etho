//
//  Habit.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation
import SwiftUI

struct Rep: Hashable {
    let date: Date
    var wasCompleted: Bool
}

struct Habit: Identifiable, Hashable {
    let id = UUID()
    var createdDate = Date()
    
    var name: String
    var color: Color
    var allowedSkipDays: Int
    
    var reps = [Rep]()
}
