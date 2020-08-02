//
//  GetMealListByNameUseCase.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

enum GetMealListResponse {
    case success(meals: [Meal])
    case empty
    case failure(error: WrappedError)
}

typealias GetMealListByNameResponseClosure = (GetMealListResponse) -> ()

protocol GetMealListByNameUseCase {
    func execute(meal: String, completion: @escaping GetMealListByNameResponseClosure)
}

final class GetMealListByNameUseCaseAdapter {
    
    var webService: GetMealListWebService
    
    init(webService: GetMealListWebService = GetMealListWebServiceAdapter(manager: NetworkManager())) {
        self.webService = webService
    }
}

extension GetMealListByNameUseCaseAdapter: GetMealListByNameUseCase {
    func execute(meal: String, completion: @escaping GetMealListByNameResponseClosure) {
        self.webService.execute(meal: meal) { (response) in
            switch response {
            case .success(let responseModel):
                guard let meals = responseModel.meals,
                    !meals.isEmpty else {
                        completion(.empty)
                        return
                }
                completion(.success(meals: meals))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
