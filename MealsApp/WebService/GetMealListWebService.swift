//
//  GetMealListWebService.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

typealias GetMealListWebServiceClosureResponse = (Result<FoodListResponseModel, WrappedError>) -> ()

protocol GetMealListWebService {
    func execute(meal: String, completion: @escaping GetMealListWebServiceClosureResponse)
}

final class GetMealListWebServiceAdapter {
    var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
}

extension GetMealListWebServiceAdapter: GetMealListWebService {
    func execute(meal: String, completion: @escaping GetMealListWebServiceClosureResponse) {
        // Query item
        let queryItem = [ URLQueryItem(name: "s", value: meal) ]
        
        let api: APIEndpoint = .getMealList
        let endpoint: URLEndpoint = api.getAPIEndpoint(queryItems: queryItem)
        
        self.manager.onlyOneCallAtTime(with: endpoint.request, endPointToCancel: .getMealList) { (response: Result<FoodListResponseModel, WrappedError>) in
            completion(response)
        }
    }
}
