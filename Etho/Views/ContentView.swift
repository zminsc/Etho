//
//  ContentView.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HabitsViewModel()
    
    @State private var selectedDate = Date()
    @State private var showingNewHabitSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Button {
                    showingNewHabitSheet = true
                } label: {
                    Text("+ habit")
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.dates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            Text("\(Calendar.current.dateComponents([.day], from: date).day!)")
                                .foregroundStyle(.black)
                                .frame(width: 50, height: 50)
                        }
                        .background(selectedDate == date ? .gray : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach($viewModel.habits.filter { $0.wrappedValue.startDate <= selectedDate }) { habit in
                        HabitCardView(habit: habit, date: selectedDate)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingNewHabitSheet) {
            NewHabitView { newHabit in
                viewModel.addHabit(newHabit)
                showingNewHabitSheet = false
            }
        }
        .onAppear {
            viewModel.loadSampleData()
        }
    }
}

struct HabitCardView: View {
    @Binding var habit: Habit
    var date: Date
    
    var idxOffset: Int {
        Calendar.current.dateComponents([.day], from: habit.startDate, to: date).day!
    }

    var body: some View {
        HStack {
            Text(habit.name)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
            
            Text("\(habit.getStreak(at: date)) ⚡")
                .font(.subheadline)
                .foregroundColor(.black)
            
            Button(action: {
                habit.isChecked[idxOffset].toggle()
            }) {
                Image(systemName: habit.isChecked[idxOffset] ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(habit.color)
        .cornerRadius(10)
    }
}

struct NewHabitView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var color = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
    @State private var consecutiveMissesAllowed = 0
    
    var onSave: (Habit) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name").font(.headline)) {
                    TextField("Running", text: $name)
                }
                
                Section(header: Text("Color").font(.headline)) {
                    ColorPicker("Pick a color", selection: $color)
                }
                
                Section(header: Text("Misses Allowed").font(.headline)) {
                    Stepper("\(consecutiveMissesAllowed)", value: $consecutiveMissesAllowed, in: 0...2)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newHabit = Habit(
                            name: name,
                            color: color,
                            consecutiveMissesAllowed: consecutiveMissesAllowed
                        )
                        
                        onSave(newHabit)
                    }
                    .disabled(name.isEmpty)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
