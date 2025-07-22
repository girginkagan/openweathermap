//
//  RestClientDelegate.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

protocol RestClientDelegate {
    func getCities(
        name: String,
        completion: @escaping (Result<CitiesResponseModel, BaseErrorModel>) -> Void
    )
    func getForecast(
        city: String,
        unit: String,
        completion: @escaping (Result<WeatherResponseModel, BaseErrorModel>) -> Void
    )
}
