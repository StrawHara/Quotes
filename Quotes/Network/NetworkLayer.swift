//
//  NetworkLayer.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation

final class NetworkLayer {
    
    // MARK: - Properties
    public static let shared: NetworkLayer = NetworkLayer()
    
    private let config = URLSessionConfiguration.default
    private lazy var session: URLSession = {
        return $0
    } (URLSession(configuration: config))

    private let queue: OperationQueue = OperationQueue()
}

// MARK: - Public Functions
extension NetworkLayer {
    
    func execute<T: Decodable>(_ router: Router, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest: URLRequest
        do {
            urlRequest = try router.asURLRequest()
        } catch {
            completion(Result.failure(error))
            return
        }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            let decoder = JSONDecoder()

            guard let data = data else { completion(Result.failure(NetworkError.unknown)); return }
            guard let responseDic = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else { completion(Result.failure(NetworkError.serialize)); return }
            guard let jsonData = try? JSONSerialization.data(withJSONObject:responseDic) else { completion(Result.failure(NetworkError.noData)); return }
            guard let decodedT = try? decoder.decode(T.self, from: jsonData) else { completion(Result.failure(NetworkError.decode)); return }

            completion(Result.success(decodedT))
        }.resume()
            
    }
    
}
