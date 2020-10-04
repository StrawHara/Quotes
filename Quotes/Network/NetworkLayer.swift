//
//  NetworkLayer.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation
import UIKit

protocol NetworkLayerDelegate: class {
    func didDisconnect()
}

final class NetworkLayer {
    
    // MARK: - Properties
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    var accesToken: String?
    
    private weak var delegate: NetworkLayerDelegate?

    // TODO: v
    private let queue: OperationQueue = OperationQueue()
    
    init(delegate: NetworkLayerDelegate?) {
        self.config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
        
        self.delegate = delegate
    }
    
}

// MARK: - Public Functions
extension NetworkLayer {
    
    func execute<T: Decodable>(_ router: Router, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest: URLRequest

        do { urlRequest = try router.asURLRequest() }
        catch { completion(Result.failure(error)); return }
        
        if let accesToken = self.accesToken {
            let headerFields = urlRequest.allHTTPHeaderFields?.merging([Network.HttpHeaderField.userToken.rawValue:accesToken], uniquingKeysWith: { (first, _) in first })
            urlRequest.allHTTPHeaderFields = headerFields
        }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            // TODO: Check server error response
            // TODO: Parse server error response if possible vv
//            {
//                "error_code": 21,
//                "message": "Invalid login or password."
//            }
            
            let decoder = JSONDecoder()

            guard let data = data else { completion(Result.failure(NetworkError.unknown)); return }
            guard let responseDic = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else { completion(Result.failure(NetworkError.serialize)); return }
            guard let jsonData = try? JSONSerialization.data(withJSONObject:responseDic) else { completion(Result.failure(NetworkError.noData)); return }
            guard let decodedT = try? decoder.decode(T.self, from: jsonData) else { completion(Result.failure(NetworkError.decode)); return }

            completion(Result.success(decodedT))
        }.resume()
            
    }
    
    func getData(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { completion(Result.failure(NetworkError.noData)); return }
            guard let image = UIImage(data: data) else { completion(Result.failure(NetworkError.decode)); return }
            completion(Result.success(image))
        }.resume()
    }
    
}
