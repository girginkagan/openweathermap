//
//  SelectCityViewModel.swift
//  openweathermap
//
//  Created by Kagan Girgin on 17/07/2025.
//

import Foundation

final class SelectCityViewModel {
    private let restClient: RestClientDelegate = RestClient()
    
    func getCities(
        name: String,
        completion: @escaping (Result<CitiesResponseModel, BaseErrorModel>) -> Void
    ) {
        restClient.getCities(
            name: name,
            completion: completion
        )
    }
}
