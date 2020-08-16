//
//  GetRandomMealUseCaseMock.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
@testable import MealsApp

final class GetRandomMealUseCaseMock: GetRandomMealUseCase {
    var response: GetRandomMealResult = .failure(error: WrappedError(cause: "Error"))
    
    func execute(completion: @escaping GetRandomMealResponseClosure) {
        completion(response)
    }
}
