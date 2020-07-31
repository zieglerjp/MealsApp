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
    var getIngredient: String { get }
}

final class MealDetailViewModelAdapter: MealDetailViewModel {
    var getInstructions: String {
        return meal.instructions
    }
    
    var getIngredient: String {
        return meal.ingredients1 ?? ""
    }
    
    var getName: String {
        return meal.name
    }
    
    private let meal: Meal
    
    init(_ meal: Meal) {
        self.meal = meal
    }
}

