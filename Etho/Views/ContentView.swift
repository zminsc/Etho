//
//  ContentView.swift
//  Etho
//
//  Created by Steven Chang on 12/21/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: HabitsViewModel
    @State private var selectedDate = Date().startOfDay()
    @State private var showingAddHabitSheet = false
    
    let lightGray = Color(red: 221 / 255.0, green: 221 / 255.0, blue: 221 / 255.0)
    let offWhite = Color(red: 253 / 255.0, green: 255 / 255.0, blue: 248 / 255.0)
    
    var body: some View {
        ZStack {
            offWhite
            
            NavigationStack {
                VStack {
                    HStack {
                        Circle()
                            .fill(lightGray)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        
                        Spacer()
                        
                        Button {
                            showingAddHabitSheet = true
                        } label: {
                            Text("Habit +")
                                .frame(width: 70, height: 30)
                                .background(lightGray)
                                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                .foregroundStyle(.black)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    DateSelectorView(selectedDate: $selectedDate)
                    
                    Divider()
                        .offset(y: -12)
                    
                    Spacer()
                        .frame(height: 48)
                    
                    HabitsListView(date: selectedDate)
                    
                    Spacer()
                }
                .padding(.all, 18)
            }
            .onAppear {
                viewModel.loadSampleData()
            }
            .sheet(isPresented: $showingAddHabitSheet) {
                AddHabitView { newHabit in
                    viewModel.habits.append(newHabit)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HabitsViewModel())
}
