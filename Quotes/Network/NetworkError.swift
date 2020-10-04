//
//  NetworkError.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation

enum NetworkError: Error {
    case networkLayerDown
    case urlEncoding
    case noData
    case serialize
    case decode
    case server(statusCode: Int)
    case unknown
}

extension NetworkError: LocalizedError {

    var prefix: String { return "🔥🔥 Network Error 🔥🔥" }

    var description: String {
        switch self {
        case .networkLayerDown: return "Network layer down"
        case .urlEncoding: return "url Encoding failed"
        case .noData: return "No Data in response"
        case .serialize: return "Serializing failed"
        case .decode: return "Decoding failed"
        case .server(let statusCode): return "Server error: \(statusCode)"
        case .unknown: return "Unknow error"
        }
    }
}
