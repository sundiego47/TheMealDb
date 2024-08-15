//
//  DessertViewModel.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import Foundation

// MARK: - DessertListViewModel
@MainActor
class DessertListViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    private var dessertService = DessertService()
    private var mealDetailsService = MealDetailsService()
        
    
    func loadDesserts() async {
        do {
            desserts = try await dessertService.fetchDesserts()
        } catch {
            print("Failed to fetch desserts: \(error)")
        }
    }
    
    func loadMealDetails(id: String) async -> MealDetails? {
        do {
            return try await mealDetailsService.fetchMealDetails(by: id)
        } catch {
            print("Failed to fetch meal details: \(error)")
            return nil
        }
    }

}
