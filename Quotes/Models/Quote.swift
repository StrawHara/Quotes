//
//  Quote.swift
//  Quotes
//
//  Created by Romain Le Drogo on 04/10/2020.
//

import Foundation

// MARK: - Model
struct Quote {
    
    let body: String
    let id: Int
    let author: String
}

// MARK: - Realm
// TODO: --

// MARK: - Decodable
extension Quote: Decodable {
    
    enum QuoteKeys: String, CodingKey {
        case body = "body"
        case id = "id"
        case author = "author"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuoteKeys.self)
        
        body = try container.decode(String.self, forKey: .body)
        id = try container.decode(Int.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
    }
    
}

// MARK: - Router
extension Quote {
    
    enum QuoteRouter: Router {
        case list
        case quote(id: Int)
        
        var method: Network.HTTPMethod {
            switch self {
            case .list, .quote(_):
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .list:
                return "quotes"
            case .quote(let id):
                return "quotes/\(id)"
            }
        }
        
        var parameters: [String: Any?] {
            return [:]
        }
        
        var headers: [String: String] {
            return [:]
        }
        
        var body: [String: Any?] {
            return [:]
        }
                
    }
    
}


