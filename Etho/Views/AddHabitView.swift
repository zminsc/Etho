//
//  AddHabitView.swift
//  Etho
//
//  Created by Steven Chang on 12/23/24.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var color = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
    @State private var allowedSkipDays = 0
    
    var onSave: (Habit) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Create a habit")) {
                    TextField("Name", text: $name)
                    ColorPicker("Color", selection: $color)
                    Stepper("Allowed Skip Days: \(allowedSkipDays)", value: $allowedSkipDays, in: 0...7)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onSave(Habit(name: name, color: color, allowedSkipDays: allowedSkipDays))
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
