//
//  MealListViewModelTests.swift
//  MealsAppTests
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import XCTest
@testable import MealsApp

class MealListViewModelTests: XCTestCase {
    
    var viewModel: MealListViewModel!
    var getMealListUseCase: GetMealListByNameUseCaseMock!
    var getRandomMealUseCase: GetRandomMealUseCaseMock!
    
    struct Constants {
        static let meal = MockedMeal().meal
        static let error = WrappedError(cause: "Failure")
    }

    override func setUp() {
        super.setUp()
        getMealListUseCase = GetMealListByNameUseCaseMock()
        getRandomMealUseCase = GetRandomMealUseCaseMock()
        viewModel = MealListViewModelAdapter(getMealListUseCase: getMealListUseCase, getRandomMealUseCase: getRandomMealUseCase)
    }

    override func tearDown() {
        viewModel = nil
        getRandomMealUseCase = nil
        getMealListUseCase = nil
        super.tearDown()
    }

    func test_getRandomMeal_Success() {
        //Setup
        getRandomMealUseCase.response = .success(meal: Constants.meal)
        
        //Test
        viewModel.getRandomMeal { (response) in
            // Verify
            switch response {
            case .success(_):
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false, "This must be a Success")
            }
        }
    }
    
    
    func test_getRandomMeal_Failure() {
        //Setup
        getRandomMealUseCase.response = .failure(error: Constants.error)
        
        //Test
        viewModel.getRandomMeal { (response) in
            // Verify
            switch response {
            case .success(_):
                XCTAssertTrue(false, "This must be a Failure")
            case .failure(_):
                XCTAssertTrue(true)
            }
        }
    }
    
    func test_getMealsSearch_Success() {
        //Setup
        getMealListUseCase.response = .success(meals: [Constants.meal])
        
        //Test
        viewModel.getMealsSearch(using: Constants.meal.name, completion: { (response) in
            switch response {
            case .success:
                XCTAssertTrue(true)
            case .empty, .failure(_):
                XCTAssertTrue(false, "This must be a Success")
            }
        })
    }
    
    
    func test_getMealsSearch_Failure() {
        //Setup
        getMealListUseCase.response = .failure(error: Constants.error)
        
        //Test
        viewModel.getMealsSearch(using: Constants.meal.name, completion: { (response) in
            switch response {
            case .failure(let error):
                XCTAssertTrue(error.cause == Constants.error.cause)
            case .empty, .success:
                XCTAssertTrue(false, "This must be a Success")
            }
        })
    }
    
    func test_getMealsSearch_Empty() {
                //Setup
        getMealListUseCase.response = .empty
        
        //Test
        viewModel.getMealsSearch(using: Constants.meal.name, completion: { (response) in
            switch response {
            case .empty:
                XCTAssertTrue(true)
            case .failure(_), .success:
                XCTAssertTrue(false, "This must be a Success")
            }
        })
    }
}
