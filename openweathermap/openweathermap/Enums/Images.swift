//
//  Images.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

import UIKit

enum Images: String {
    case icLogo
    
    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
