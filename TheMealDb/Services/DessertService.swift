//
//  DessertService.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import Foundation

// MARK: DessertService

struct DessertService {
    private let baseURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let apiKey = "1" // API Key for developer testing

    func fetchDesserts() async throws -> [Dessert] {
        let urlString = "\(baseURL)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let dessertResponse = try JSONDecoder().decode(DessertResponse.self, from: data)
        return dessertResponse.meals
    }
}


