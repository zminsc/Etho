//
//  HabitsViewModel.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits = [Habit]()
    
    var earliestDate: Date? = nil
    
    var dates: [Date] {
        let startDate = earliestDate ?? Date()
        let endDate = Date()
        
        var currentDate = startDate
        var datesToReturn = [Date]()
        
        while currentDate <= endDate {
            datesToReturn.append(currentDate)
            currentDate = Calendar.current.date(byAdding: DateComponents(day: 1), to: currentDate)!
        }
        
        return datesToReturn.reversed()
    }

    func addHabit(_ habit: Habit) {
        guard !habit.name.isEmpty else { return }
        
        if let earliestDate = earliestDate {
            self.earliestDate = min(earliestDate, habit.startDate)
        } else {
            earliestDate = habit.startDate
        }
        
        habits.append(habit)
    }

    func loadSampleData() {
        let calendar = Calendar.current

        let habitsToAdd = [
            Habit(
                name: "Read",
                color: .purple,
                startDate: calendar.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
                isChecked: [true, true, true, false, true, true, false, false, true, true, true, false, false, false, true, true, false, true, true, true, false],
                consecutiveMissesAllowed: 0
            ),
            Habit(
                name: "Meditate",
                color: .orange,
                startDate: calendar.date(byAdding: .day, value: -15, to: Date()) ?? Date(),
                isChecked: [false, true, true, false, true, true, false, false, true, true, true, false, true, false, true, true],
                consecutiveMissesAllowed: 1
            ),
            Habit(
                name: "Run",
                color: .blue,
                startDate: calendar.date(byAdding: .day, value: -10, to: Date()) ?? Date(),
                isChecked: [true, false, true, true, false, false, true, false, true, true, false],
                consecutiveMissesAllowed: 2
            ),
            Habit(
                name: "Study",
                color: .red,
                startDate: calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
                isChecked: [true, false, true, false, true, false, true, false],
                consecutiveMissesAllowed: 3
            ),
            Habit(
                name: "Drink Water",
                color: .green,
                startDate: calendar.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                isChecked: [true, true, false, true, false, false],
                consecutiveMissesAllowed: 1
            )
        ]
        
        for habit in habitsToAdd {
            self.addHabit(habit)
        }
    }
}

