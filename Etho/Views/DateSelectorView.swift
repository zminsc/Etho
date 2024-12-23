//
//  DateSelectorView.swift
//  Etho
//
//  Created by Steven Chang on 12/23/24.
//

import SwiftUI

struct DateSelectorView: View {
    @Binding var selectedDate: Date
    
    @EnvironmentObject private var viewModel: HabitsViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.dateRange.reversed(), id: \.self) { date in
                    DateSelectorButton(date: date, isSelected: Calendar.current.isDate(selectedDate, inSameDayAs: date)) {
                        selectedDate = date
                    }
                }
            }
            .frame(height: 48)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct DateSelectorButton: View {
    var date: Date
    var isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text("\(dayOfMonth)")
                    .font(.subheadline)
                
                Text(dayAbbreviation)
                    .font(.subheadline)
                
                Spacer()
                    .frame(height: isSelected ? 2 : 3)
                
                Rectangle()
                    .fill(.black)
                    .frame(height: isSelected ? 1 : 0)
            }
            .frame(width: 25)
            .foregroundStyle(.black)
        }
    }
    
    private var dayOfMonth: Int {
        Calendar.current.component(.day, from: date)
    }
    
    private var dayAbbreviation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let fullWeekdayName = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return String(fullWeekdayName.prefix(2))
    }
}


