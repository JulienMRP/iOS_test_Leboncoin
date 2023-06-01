//
//  String+DateCompare.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import Foundation

extension String {
    func isAfter(_ date: String) -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        guard let firstDate = dateFormatter.date(from: self),
              let secondDate = dateFormatter.date(from: date) else {
            return false
        }
        return firstDate > secondDate
    }
    
    func dateToFormattedString() -> String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY à HH'h'mm"
        return formatter.string(from: date)
    }
}
