//
//  HabitsViewModel.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits = [Habit]()
    
    func addHabit(_ habit: Habit) {
        guard !habit.name.isEmpty else { return }
        habits.append(habit)
    }

    func loadSampleData() {
        let calendar = Calendar.current

        habits = [
            Habit(
                name: "Run",
                color: .blue,
                startDate: calendar.date(byAdding: .day, value: -10, to: Date()) ?? Date(),
                isChecked: [true, false, true, true, false, false, true, false, true, true],
                consecutiveMissesAllowed: 2
            ),
            Habit(
                name: "Drink Water",
                color: .green,
                startDate: calendar.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                isChecked: [true, true, false, true, false],
                consecutiveMissesAllowed: 1
            ),
            Habit(
                name: "Study",
                color: .red,
                startDate: calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
                isChecked: [true, false, true, false, true, false, true],
                consecutiveMissesAllowed: 3
            ),
            Habit(
                name: "Read",
                color: .purple,
                startDate: calendar.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
                isChecked: [true, true, true, false, true, true, false, false, true, true, true, false, false, false, true, true, false, true, true, true],
                consecutiveMissesAllowed: 0
            ),
            Habit(
                name: "Meditate",
                color: .orange,
                startDate: calendar.date(byAdding: .day, value: -15, to: Date()) ?? Date(),
                isChecked: [false, true, true, false, true, true, false, false, true, true, true, false, true, false, true],
                consecutiveMissesAllowed: 1
            )
        ]
    }
}

