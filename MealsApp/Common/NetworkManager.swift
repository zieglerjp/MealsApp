//
//  NetworkManager.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct WrappedError: Error {
  let cause: String
}

protocol NetworkManagerProtocol {
    func get<T: Decodable>(with endPoint: EndPoints, parameters: [String: String]?, completion: @escaping (Result<T, WrappedError>)-> Void)
}

final class NetworkManager {
    
    struct Dependencies {
        let urlSession = URLSession.shared
        let mainURL = "https://www.themealdb.com/api/json/v1/1/"
    }
    
    struct Constants {
        static let timeOut = 30.0
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension NetworkManager: NetworkManagerProtocol {
    
    func get<T: Decodable>(with endPoint: EndPoints, parameters: [String : String]?, completion: @escaping (Result<T, WrappedError>) -> Void) {
 
        let urlWithEndpoint = dependencies.mainURL + endPoint.rawValue
        
        guard let completeUrl = URL(string: urlWithEndpoint + "?" + (parameters?.stringFromHttpParameters() ?? "")) else {
            return
        }
        let request = NSMutableURLRequest(url: completeUrl as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: Constants.timeOut)
        request.httpMethod = "GET"
        
        let dataTask = dependencies.urlSession.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(.failure(WrappedError(cause: error!.localizedDescription)))
            } else {
                guard let data = data else {
                    completion(.failure(WrappedError(cause: "Data is Nil")))
                    return
                }
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseData))
                }
                catch let error{
                    print(error)
                    completion(.failure(WrappedError(cause: "Failed when Parsing")))
                }
            }
        })

        dataTask.resume()
    }
    
}


