//
//  FoodListResponseModel.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct FoodListResponseModel: Codable {
    let meals: [Meal]?
}
