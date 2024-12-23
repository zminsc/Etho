//
//  HabitsViewModel.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation
import SwiftUI

class HabitsViewModel: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            rebuildCaches()
        }
    }
    
    var wasCompletedCache: [Habit: [Date: Bool]] = [:]
    var streaksCache: [Habit: [Date: Int]] = [:]
    
    var dateRange: [Date] {
        guard let earliestDate = habits.sorted(by: { $0.createdDate < $1.createdDate }).first?.createdDate else {
            return []
        }
        
        // Generate dates from the earliest date to the current date
        let today = Date().startOfDay()
        var dates: [Date] = []
        var currentDate = earliestDate.startOfDay()
        
        while currentDate <= today {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    func toggleWasCompleted(for habit: Habit, on date: Date) {
        guard let habitIdx = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if let repIdx = habits[habitIdx].reps.firstIndex(where: { $0.date.startOfDay() == date.startOfDay()}) {
            habits[habitIdx].reps[repIdx].wasCompleted.toggle()
        } else {
            habits[habitIdx].reps.append(Rep(date: date, wasCompleted: true))
        }
    }
    
    func rebuildCaches() {
        wasCompletedCache.removeAll()
        streaksCache.removeAll()
        for habit in habits {
            buildCaches(for: habit)
        }
    }
    
    func buildCaches(for habit: Habit) {
        var streaks: [Date: Int] = [:]
        var wasCompleted: [Date: Bool] = [:]
        
        let sortedReps = habit.reps.sorted(by: { $0.date < $1.date })
        var streak = 0
        var skipDays = 0
        for i in 0..<sortedReps.count {
            wasCompleted[sortedReps[i].date.startOfDay()] = sortedReps[i].wasCompleted
            if skipDays > habit.allowedSkipDays {
                streak = 0
            }
            if sortedReps[i].wasCompleted {
                streak += 1
                skipDays = 0
            } else {
                skipDays += 1
            }
            streaks[sortedReps[i].date.startOfDay()] = streak
        }
        
        streaksCache[habit] = streaks
        wasCompletedCache[habit] = wasCompleted
    }
    
    func loadSampleData() {
        let pastelRed = Color(red: 255 / 255.0, green: 206 / 255.0, blue: 206 / 255.0)
        let pastelGreen = Color(red: 185 / 255.0, green: 244 / 255.0, blue: 228 / 255.0)
        let pastelBlue = Color(red: 199 / 255.0, green: 219 / 255.0, blue: 255 / 255.0)
        let pastelPink = Color(red: 255 / 255.0, green: 216 / 255.0, blue: 235 / 255.0)
        
        habits = [
            Habit(
                createdDate: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
                name: "Meditate",
                color: pastelRed,
                allowedSkipDays: 0,
                reps: (0..<21).map { offset in
                    let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
                    return Rep(date: date, wasCompleted: [true, true, true, false, true, true, false, false, true, true, true, false, false, false, true, true, false, true, true, true, false].reversed()[offset] ?? false)
                }
            ),
            Habit(
                createdDate: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
                name: "Run",
                color: pastelGreen,
                allowedSkipDays: 2,
                reps: (0..<16).map { offset in
                    let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
                    return Rep(date: date, wasCompleted: [false, true, true, false, true, true, false, false, true, true, true, false, true, false, true, true].reversed()[offset] ?? false)
                }
            ),
            Habit(
                createdDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                name: "Read",
                color: pastelBlue,
                allowedSkipDays: 3,
                reps: (0..<11).map { offset in
                    let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
                    return Rep(date: date, wasCompleted: [true, false, true, true, false, false, true, false, true, true, false].reversed()[offset] ?? false)
                }
            ),
            Habit(
                createdDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                name: "Wash Face",
                color: pastelPink,
                allowedSkipDays: 0,
                reps: (0..<8).map { offset in
                    let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
                    return Rep(date: date, wasCompleted: [true, false, true, false, true, false, true, false].reversed()[offset] ?? false)
                }
            )
        ]
    }
}

