//
//  NetworkManager.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func onlyOneCallAtTime<T: Decodable> (with request: URLRequest, endPointToCancel: APIEndpoint, completion: @escaping (Result<T, WrappedError>) -> Void)
    func callAPI<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, WrappedError>)-> Void)
}

final class NetworkManager {
    
    struct Dependencies {
        let urlSession = URLSession.shared
    }
    
    struct Constants {
        static let timeOut = 30.0
    }
    
    var dependencies: Dependencies
    var calls = [String: URLSessionDataTask]()
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func onlyOneCallAtTime<T: Decodable> (with request: URLRequest,
                                          endPointToCancel: APIEndpoint,
                                          completion: @escaping (Result<T, WrappedError>) -> Void) {
        if let dataTaskToCancel = calls[endPointToCancel.rawValue] {
            dataTaskToCancel.cancel()
        }
        let dataTask = createDataTask(with: request, completion: completion)
        calls[endPointToCancel.rawValue] = dataTask
        dataTask.resume()
    }
    
    private func createDataTask<T: Decodable>(with request: URLRequest,
                                completion: @escaping (Result<T, WrappedError>) -> Void) -> URLSessionDataTask {
        return dependencies.urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
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
    }
    
    func callAPI<T: Decodable> (with request: URLRequest,
                              completion: @escaping (Result<T, WrappedError>) -> Void) {
        createDataTask(with: request, completion: completion).resume()
    }
    
}


