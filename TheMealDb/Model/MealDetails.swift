//
//  Meal.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import Foundation

// MARK: MealDetailResponse
struct MealDetailResponse: Codable {
    let meals: [MealDetails]
}


// MARK: - MealDetails
struct MealDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    let ingredients: [String: String]  // Ingredient to Measurement mapping
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode static keys
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try? container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strTags = try? container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try? container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try? container.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try? container.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try? container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try? container.decodeIfPresent(String.self, forKey: .dateModified)
        
        
        // Decode dynamic ingredients and measurements
        var ingredientsDict = [String: String]()
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var index = 1
        while true {
            let ingredientKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            guard let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: ingredientKey)!) else {
                // Break the loop if the ingredient key is not found
                break
            }
            
            if !ingredient.isEmpty {
                let measurement = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: measureKey)!)
                ingredientsDict[ingredient] = measurement ?? ""
            }
            
            index += 1
        }
        
        ingredients = ingredientsDict
    }
}


// Dynamic Coding Keys for accessing dynamic keys
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
