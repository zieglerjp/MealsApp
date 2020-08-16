//
//  GetRandomMealUseCaseTests.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import XCTest
@testable import MealsApp

class GetRandomMealUseCaseTests: XCTestCase {
    
    var useCase: GetRandomMealUseCase!
    var webService: GetRandomMealWebServiceMock!
    
    struct Constants {
        static let meal = MockedMeal().meal
        static let error = WrappedError(cause: "Failure")
    }

    override func setUp() {
        super.setUp()
        webService = GetRandomMealWebServiceMock()
        useCase = GetRandomMealUseCaseAdapter(webService: webService)
    }

    override func tearDown() {
        useCase = nil
        webService = nil
        super.tearDown()
    }
    
    func test_getMealsSearch_Success() {
        //Setup
        webService.response = .success(FoodListResponseModel(meals: [Constants.meal]))
        
        //Test
        useCase.execute { (response) in
            //verify
            switch response {
            case .success(let meals):
                XCTAssertTrue(Constants.meal.id == meals.id, "must be equals")
            case .failure(_):
                XCTAssertTrue(false, "must be success")
            }
        }
    }
    
    
    func test_getMealsSearch_Failure() {
        //Setup
        webService.response = .failure(Constants.error)
        
        //Test
        useCase.execute{ (response) in
            //verify
            switch response {
            case .failure(let error):
                XCTAssertTrue(Constants.error.cause == error.cause, "must be equals")
            case .success(_):
                XCTAssertTrue(false, "must be Failure")
            }
        }
    }
}
