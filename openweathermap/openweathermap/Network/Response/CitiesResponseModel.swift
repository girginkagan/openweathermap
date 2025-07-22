//
//  CitiesResponseModel.swift
//  openweathermap
//
//  Created by Kagan Girgin on 17/07/2025.
//

// MARK: - CitiesResponseModelElement
struct CitiesResponseModelElement: Codable {
    let name: String?
    let latitude, longitude: Double?
    let country: String?
    let population: Int?
    let region: String?
    let isCapital: Bool?

    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude, country, population, region
        case isCapital = "is_capital"
    }
}

typealias CitiesResponseModel = [CitiesResponseModelElement]
