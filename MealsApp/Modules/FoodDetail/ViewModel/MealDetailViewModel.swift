//
//  MealDetailViewModel.swift
//  MealsApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

protocol MealDetailViewModel {
    var getInstructions: String { get }
    var getName: String { get }
    var getIngredients: [String] { get }
}

final class MealDetailViewModelAdapter: MealDetailViewModel {
    var getInstructions: String {
        return meal.instructions
    }
    
    var getIngredients: [String] {
        return meal.ingredients
    }
    
    var getName: String {
        return meal.name
    }
    
    private let meal: Meal
    
    init(_ meal: Meal) {
        self.meal = meal
    }
}

