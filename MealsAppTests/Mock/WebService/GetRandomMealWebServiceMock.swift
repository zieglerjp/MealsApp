//
//  GetRandomMealWebServiceMock.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
@testable import MealsApp

final class GetRandomMealWebServiceMock: GetRandomMealWebService {
    var response: Result<FoodListResponseModel, WrappedError> = .failure(WrappedError(cause: "Error"))
    
    func execute(completion: @escaping GetRandomMealWebServiceClosureResponse) {
        completion(response)
    }
}
