//
//  QuotePage.swift
//  Quotes
//
//  Created by Romain Le Drogo on 04/10/2020.
//

import Foundation

// MARK: - Model
struct QuotePage {
    
    let nb: Int
    let last: Bool
    let quotes: [Quote]

}

// MARK: - Realm
// TODO: --

// MARK: - Decodable
extension QuotePage: Decodable {
    
    enum QuotePageKeys: String, CodingKey {
        case nb = "page"
        case last = "last_page"
        case quotes = "quotes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuotePageKeys.self)
        
        nb = try container.decode(Int.self, forKey: .nb)
        last = try container.decode(Bool.self, forKey: .last)
        quotes = try container.decode([Quote].self, forKey: .quotes)
    }
    
}

// MARK: - Router
extension QuotePage {
    
    enum QuotePageRouter: Router {
        case any
        case page(nb: Int)
        
        var method: Network.HTTPMethod {
            switch self {
            case .any, .page(_):
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .any, .page(_):
                return "quotes"
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


