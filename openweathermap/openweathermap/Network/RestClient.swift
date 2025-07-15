//
//  RestClient.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

import Foundation

final class RestClient: RestClientDelegate {
    private func sendRequest<T: Codable?>(
        request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                return
            }
            
            
        }
    }
    
    func getCities() {
        
    }
    
    func getForecast() {
        
    }
}
