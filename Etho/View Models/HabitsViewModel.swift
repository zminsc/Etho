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
}
