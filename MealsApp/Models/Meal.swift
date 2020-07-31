//
//  Meal.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct Meal: Codable {
    let id: String
    let category: String
    let image: URL
    let name: String
    let instructions: String
    let ingredients1: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case category = "strCategory"
        case image = "strMealThumb"
        case name = "strMeal"
        case instructions = "strInstructions"
        case ingredients1 = "strIngredient1"
    }
}
