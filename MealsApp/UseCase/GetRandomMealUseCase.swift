//
//  GetRandomMealUseCase.swift
//  MealsApp
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

enum GetRandomMealResult {
    case success(meal: Meal)
    case failure(error: Error)
}

typealias GetRandomMealResponseClosure = (GetRandomMealResult) -> ()

protocol GetRandomMealUseCase {
    func execute(completion: @escaping GetRandomMealResponseClosure)
}

final class GetRandomMealUseCaseAdapter {
    
    var webService: GetRandomMealWebService
    
    init(webService: GetRandomMealWebService = GetRandomMealWebServiceAdapter(manager: NetworkManager())) {
        self.webService = webService
    }
}

extension GetRandomMealUseCaseAdapter: GetRandomMealUseCase {
    func execute(completion: @escaping GetRandomMealResponseClosure) {
        self.webService.execute { (response) in
            switch response {
            case .success(let responseModel):
                guard let meals = responseModel.meals,
                    let meal = meals.first else {
                        completion(.failure(error: WrappedError(cause: "no meals founded")))
                    return
                }
                completion(.success(meal: meal))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
