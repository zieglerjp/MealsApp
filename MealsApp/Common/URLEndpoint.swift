//
//  URLEndpoint.swift
//  MealsApp
//
//  Created by Juan Ziegler on 09/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

enum HTTPMethod: String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
    case head       = "HEAD"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case options    = "OPTIONS"
}

public struct URLEndpoint {
    var path: String
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?
    var body: Data?
    var queryItems: [URLQueryItem]?
}

// MARK: - Request Setup

extension URLEndpoint {
    
    var urlComponents: URLComponents {
        let base: String = "https://www.themealdb.com"
        var component = URLComponents(string: base)!
        component.path = path
        component.queryItems = queryItems
        return component
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod  = httpMethod.rawValue
        request.httpBody    = body
        if  let headers = headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        request.httpShouldHandleCookies = true
        return request
    }
}
