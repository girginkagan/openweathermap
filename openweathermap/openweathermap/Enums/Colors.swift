//
//  Colors.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

import UIKit

enum Colors: String {
    case mainBackground
    case white
    
    var color: UIColor? {
        UIColor(named: rawValue)
    }
}
