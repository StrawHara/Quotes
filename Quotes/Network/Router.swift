//
//  Router.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation

protocol Router {

    func asURLRequest() throws -> URLRequest
    var method: Network.HTTPMethod {get}
    var path: String {get}
    
    var parameters: [String: Any?] {get}
    var headers: [String: String] {get}
    var body: [String: Any?] {get}

}

extension Router {
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: Network.baseUrl) else {
            throw NetworkError.urlEncoding
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path + parameters.queryString))
        
        urlRequest.httpMethod = method.rawValue
                
        let headerFields = Network.baseHeader.merging(headers, uniquingKeysWith: { (first, _) in first })
        urlRequest.allHTTPHeaderFields = headerFields
        
        if method != .get {
            let bodyData = try? JSONSerialization.data(withJSONObject: body)
            urlRequest.httpBody = bodyData
        }

        urlRequest.timeoutInterval = 60
        urlRequest.httpShouldHandleCookies = false
        
        return urlRequest
    }
    
}
