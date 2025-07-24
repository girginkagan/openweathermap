//
//  DataProvider.swift
//  openweathermap
//
//  Created by Kagan Girgin on 22/07/2025.
//

import Foundation

final class DataProvider {
    static let sharedInstance = DataProvider()
    
    var selectedCity = ""
    var selectedUnit = "metric"
}
