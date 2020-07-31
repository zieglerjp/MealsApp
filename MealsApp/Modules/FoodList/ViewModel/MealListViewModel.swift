//
//  FoodListViewModel.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

enum GetMealsSearchResponse {
    case success
    case empty
    case failure(Error)
}

protocol MealListViewModel {
    var mealsList: [Meal] { get }
    
    func getMealsSearch(using text: String, completion: @escaping (GetMealsSearchResponse) -> ())
}

final class MealListViewModelAdapter {
    var useCase: GetMealListByNameUseCase
    
    var mealsList = [Meal]()
    
    init(useCase: GetMealListByNameUseCase = GetMealListByNameUseCaseAdapter()) {
        self.useCase = useCase
    }
}

extension MealListViewModelAdapter: MealListViewModel {
    func getMealsSearch(using text: String, completion: @escaping (GetMealsSearchResponse) -> ()) {
        self.useCase.execute(meal: text) { (response) in
            switch response {
            case .success(let meals):
                self.mealsList = meals
                completion(.success)
            case .empty:
                self.mealsList = []
                completion(.empty)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

