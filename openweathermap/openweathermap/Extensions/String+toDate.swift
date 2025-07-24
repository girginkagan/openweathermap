//
//  String+toDate.swift
//  openweathermap
//
//  Created by Kagan Girgin on 22/07/2025.
//

import Foundation

extension String {
    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self)
        
        return date
    }
}
