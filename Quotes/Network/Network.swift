//
//  Environment.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation

struct Network {

    static let baseUrl = "https://favqs.com/api/"
    static let apiKey = "Token token=9e9c7d2ce1a7560b00c18b52cbd770c4"

    static let baseHeader: [String: String] = [
        HttpHeaderField.authentication.rawValue: apiKey,
        HttpHeaderField.contentType.rawValue: ContentType.json.rawValue
    ]
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum ContentType: String {
        case json = "application/json"
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}
