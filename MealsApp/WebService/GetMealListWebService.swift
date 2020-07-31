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
        let parameters = ["s": meal]
        self.manager.get(with: .getMealList, parameters: parameters) { (response: Result<FoodListResponseModel, WrappedError>) in
            completion(response)
        }
    }
}
