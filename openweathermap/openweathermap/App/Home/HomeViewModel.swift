//
//  HomeViewModel.swift
//  openweathermap
//
//  Created by Kagan Girgin on 22/07/2025.
//

import Foundation

final class HomeViewModel {
    private let restClient: RestClientDelegate = RestClient()
    
    func getForecast(
        city: String,
        unit: String,
        completion: @escaping (Result<WeatherResponseModel, BaseErrorModel>) -> Void
    ) {
        restClient.getForecast(
            city: city,
            unit: unit,
            completion: completion
        )
    }
}
