//
//  RestClient.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

import Foundation

final class RestClient: RestClientDelegate {
    private func sendRequest<T: Codable>(
        request: URLRequest,
        completion: @escaping (Result<T, BaseErrorModel>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.genericError(message: "An error occured")))
                }
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.genericError(message: error.localizedDescription)))
                }
            }
        }.resume()
    }
    
    func getCities(
        name: String,
        completion: @escaping (Result<CitiesResponseModel, BaseErrorModel>) -> Void
    ) {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/city?name=" + name) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("uCRzkhffZIg3zyEreZMVZg==VOR0Jg27yOO1PdCk", forHTTPHeaderField: "X-Api-Key")
        sendRequest(request: request, completion: completion)
    }
    
    func getForecast(
        city: String,
        unit: String,
        completion: @escaping (Result<WeatherResponseModel, BaseErrorModel>) -> Void
    ) {
        guard let url = URL(
            string: "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=\(unit)&APPID=7143dce5516e5adc2e1b97920dbd08cb"
        ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        sendRequest(request: request, completion: completion)
    }
}
