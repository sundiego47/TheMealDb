//
//  Dessert.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import Foundation

// MARK: - DessertResponse and Dessert Models
struct DessertResponse: Codable {
    let meals: [Dessert]
}


struct Dessert: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { strMeal }
}


