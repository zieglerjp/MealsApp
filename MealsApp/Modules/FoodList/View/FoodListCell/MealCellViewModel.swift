//
//  MealCellViewModel.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

protocol MealCellViewModel {
    var getImage: URL? { get }
    var getName: String { get }
    var getCategory: String { get }
}

final class MealCellViewModelAdapter: MealCellViewModel {
    var getImage: URL? {
        return meal.imageURL
    }
    
    var getName: String {
        return meal.name
    }
    
    var getCategory: String {
        return meal.category
    }
    
    private let meal: Meal
    
    init(_ meal: Meal) {
        self.meal = meal
    }
}
