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
    case failure(WrappedError)
}

enum GetRandomMealResponse {
    case success(URL)
    case failure(WrappedError)
}

protocol MealListViewModel {
    var mealsList: [Meal] { get }
    func getMealsSearch(using text: String, completion: @escaping (GetMealsSearchResponse) -> ())
    func getRandomMeal(completion: @escaping (GetRandomMealResponse) -> ())
}

final class MealListViewModelAdapter {
    private var getMealListUseCase: GetMealListByNameUseCase
    private var getRandomMealUseCase: GetRandomMealUseCase
    var mealsList = [Meal]()
    
    init(getMealListUseCase: GetMealListByNameUseCase = GetMealListByNameUseCaseAdapter(),
         getRandomMealUseCase: GetRandomMealUseCase = GetRandomMealUseCaseAdapter()) {
        self.getMealListUseCase = getMealListUseCase
        self.getRandomMealUseCase = getRandomMealUseCase
    }
}

extension MealListViewModelAdapter: MealListViewModel {
    func getRandomMeal(completion: @escaping (GetRandomMealResponse) -> ()) {
        self.getRandomMealUseCase.execute { (response) in
            switch response {
            case .success(let meal):
                guard let mealImage = meal.imageURL else {
                    completion(.failure(WrappedError(cause: "Error")))
                    return
                }
                completion(.success(mealImage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMealsSearch(using text: String, completion: @escaping (GetMealsSearchResponse) -> ()) {
        self.getMealListUseCase.execute(meal: text) { [weak self] (response) in
            switch response {
            case .success(let meals):
                self?.mealsList = meals
                completion(.success)
            case .empty:
                self?.mealsList = []
                completion(.empty)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

