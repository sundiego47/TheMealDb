//
//  MealDetailService.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import Foundation

// MARK: MealDetailsService

class MealDetailsService {
    func fetchMealDetails(by id: String) async throws -> MealDetails {
        let baseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        print("Looking up dessert")
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        print(mealDetailResponse)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.badServerResponse)
        }
//        print(mealDetail)
        
        return mealDetail
    }
}
