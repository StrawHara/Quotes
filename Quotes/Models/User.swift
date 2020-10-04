//
//  User.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import Foundation

// MARK: - Model
struct User {
    
    let login: String
    let pictureUrl: String
    let publicFavoritesCount: Int
    let followers: Int
    let following: Int
    let pro: Bool
}

// MARK: - Realm
// TODO: --

// MARK: - Decodable
extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case login = "login"
        case pictureUrl = "pic_url"
        case publicFavoritesCount = "public_favorites_count"
        case followers = "followers"
        case following = "following"
        case pro = "pro"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        
        login = try container.decode(String.self, forKey: .login)
        pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        publicFavoritesCount = try container.decode(Int.self, forKey: .publicFavoritesCount)
        followers = try container.decode(Int.self, forKey: .followers)
        following = try container.decode(Int.self, forKey: .following)
        pro = try container.decode(Bool.self, forKey: .pro)
    }
    
}

// MARK: - Router
extension User {
    
    enum UserRouter: Router {
        case get(login: String)
        
        var method: Network.HTTPMethod {
            switch self {
            case .get:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .get(let login):
                return "users/\(login)"
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


