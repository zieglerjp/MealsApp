//
//  GetRandomMealWebService.swift
//  MealsApp
//
//  Created by Juan Ziegler on 02/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

typealias GetRandomMealWebServiceClosureResponse = (Result<FoodListResponseModel, WrappedError>) -> ()

protocol GetRandomMealWebService {
    func execute(completion: @escaping GetRandomMealWebServiceClosureResponse)
}

final class GetRandomMealWebServiceAdapter {
    var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
}

extension GetRandomMealWebServiceAdapter: GetRandomMealWebService {
    func execute(completion: @escaping GetRandomMealWebServiceClosureResponse) {
        let api: APIEndpoint = .getRandomMeal
        let endpoint: URLEndpoint = api.getAPIEndpoint()
        
        self.manager.callAPI(with: endpoint.request) { (response: Result<FoodListResponseModel, WrappedError>) in
            completion(response)
        }
    }
}
