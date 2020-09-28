//
//  Session.swift
//  Quotes
//
//  Created by Romain le Drogo on 28/09/2020.
//

import Foundation

// MARK: - Model
struct Session {
    
    let userToken: String
    let email: String
    let login: String
    
}

// MARK: - Realm
// TODO: --

// MARK: - Decodable
extension Session: Decodable {
    
    enum SessionKeys: String, CodingKey {
        case userToken = "User-Token"
        case email = "email"
        case login = "login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SessionKeys.self)
        
        userToken = try container.decode(String.self, forKey: .userToken)
        email = try container.decode(String.self, forKey: .email)
        login = try container.decode(String.self, forKey: .login)
    }
    
}

// MARK: - Router
extension Session {
    
    enum SessionRouter: Router {
        case login(login: String, password: String)
        case logout
        
        var method: Network.HTTPMethod {
            switch self {
            case .login:
                return .post
            case .logout:
                return .delete
            }
        }
        
        var path: String {
            return "session"
        }
        
        var parameters: [String: Any?] {
            return [:]
        }
        
        var headers: [String: String] {
            return [:]
        }
        
        var body: [String: Any?] {
            switch self {
            case .login(let login, let password):
                return [
                    "user":
                        [
                            "login" : login,
                            "password" : password
                        ]
                ]
            default:
                return [:]
            }
        }
        
    }
    
}


