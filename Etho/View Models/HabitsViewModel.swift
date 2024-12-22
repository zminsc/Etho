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
        habits = [
            Habit(name: "Run", color: .blue, isChecked: [true, false, true], consecutiveMissesAllowed: 2),
            Habit(name: "Drink Water", color: .green, isChecked: [true, true, false], consecutiveMissesAllowed: 1),
            Habit(name: "Study", color: .red, isChecked: [false, true, false, true], consecutiveMissesAllowed: 3),
            Habit(name: "Meditate", color: .orange, isChecked: [false, false, true], consecutiveMissesAllowed: 1)
        ]
    }
}

