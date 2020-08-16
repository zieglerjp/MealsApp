//
//  EndPoints.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

enum APIEndpoint: String {
    case getMealList = "/api/json/v1/1/search.php"
    case getRandomMeal = "/api/json/v1/1/random.php"
    
    // To get the API endpoint with request setup
    func getAPIEndpoint(queryItems: [URLQueryItem]? = [], headers: HTTPHeaders? = [:], body: Data? = Data()) -> URLEndpoint {
            return URLEndpoint(path: self.rawValue, httpMethod: .post, headers: headers, body: body, queryItems: queryItems)
    }
}
