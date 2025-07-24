//
//  Date+toString.swift
//  openweathermap
//
//  Created by Kagan Girgin on 22/07/2025.
//

import Foundation

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
