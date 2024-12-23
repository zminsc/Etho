//
//  DateExtensions.swift
//  Etho
//
//  Created by Steven Chang on 12/23/24.
//

import Foundation

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
