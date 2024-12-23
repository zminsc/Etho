//
//  HabitsListView.swift
//  Etho
//
//  Created by Steven Chang on 12/23/24.
//

import SwiftUI

struct HabitsListView: View {
    var date: Date
    
    @EnvironmentObject private var viewModel: HabitsViewModel
    private var habits: [Habit] {
        viewModel.habits.filter { $0.createdDate.startOfDay() <= date.startOfDay() }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(habits) { habit in
                    HabitCardView(habit: habit, date: date)
                }
            }
        }
    }
}

struct HabitCardView: View {
    var habit: Habit
    var date: Date
    
    @EnvironmentObject private var viewModel: HabitsViewModel
    
    var body: some View {
        HStack {
            Text(habit.name)
                .bold()
            
            Spacer()
            
            Text("\(viewModel.streaksCache[habit]?[date.startOfDay()] ?? 0) ⚡")
            
            Button {
                viewModel.toggleWasCompleted(for: habit, on: date)
            } label: {
                Image(systemName: (viewModel.wasCompletedCache[habit]?[date.startOfDay()] ?? false) ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(height: 64)
        .background(habit.color)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}
