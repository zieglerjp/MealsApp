//
//  GetMealListByNameUseCaseTest.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import XCTest
@testable import MealsApp

class GetMealListByNameUseCaseTest: XCTestCase {
    
    var useCase: GetMealListByNameUseCase!
    var webService: GetMealListWebServiceMock!
    
    struct Constants {
        static let meal = MockedMeal().meal
        static let error = WrappedError(cause: "Failure")
    }

    override func setUp() {
        super.setUp()
        webService = GetMealListWebServiceMock()
        useCase = GetMealListByNameUseCaseAdapter(webService: webService)
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
        useCase.execute(meal: Constants.meal.name) { (response) in
            //verify
            switch response {
            case .success(let meals):
                XCTAssertTrue(Constants.meal.id == meals.first!.id, "must be equals")
            case .empty, .failure(_):
                XCTAssertTrue(false, "must be success")
            }
        }
    }
    
    
    func test_getMealsSearch_Failure() {
        //Setup
        webService.response = .failure(Constants.error)
        
        //Test
        useCase.execute(meal: Constants.meal.name) { (response) in
            //verify
            switch response {
            case .failure(let error):
                XCTAssertTrue(Constants.error.cause == error.cause, "must be equals")
            case .success(_), .empty:
                XCTAssertTrue(false, "must be Failure")
            }
        }
    }
    
    func test_getMealsSearch_Empty() {
        //Setup
        webService.response = .success(FoodListResponseModel(meals: []))
        
        //Test
        useCase.execute(meal: Constants.meal.name) { (response) in
            //verify
            switch response {
            case .empty:
                XCTAssertTrue(true)
            case .success(_), .failure(_):
                XCTAssertTrue(false, "must be Empty")
            }
        }
    }
}
