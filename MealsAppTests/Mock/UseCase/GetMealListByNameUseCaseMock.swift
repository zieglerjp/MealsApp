//
//  GetMealListByNameUseCaseMock.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
@testable import MealsApp

final class GetMealListByNameUseCaseMock: GetMealListByNameUseCase {
    var response: GetMealListResponse = .success(meals: [])
    func execute(meal: String, completion: @escaping GetMealListByNameResponseClosure) {
        completion(response)
    }
}
