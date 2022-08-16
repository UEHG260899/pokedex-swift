//
//  Networker.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import Foundation

struct Networker {
    
    enum HTTPMethods: String {
        case get = "GET"
    }
    
    enum NetworkerErrors: Error {
        case unknown
        case invalidResponse(URLResponse)
        case requestFailed(HTTPURLResponse)
        case deserializationFailed(String)
    }
    
    func response(for request: URLRequest, completion: @escaping (Result<(HTTPURLResponse, Data), NetworkerErrors>) -> (Void)) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response,
                  let data = data else {
                debugPrint(error?.localizedDescription)
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse(response)))
                return
            }
            
            completion(.success((httpResponse, data)))
            
        }.resume()
    }
    
    func data(for request: URLRequest, completion: @escaping (Result<Data, NetworkerErrors>) -> (Void)) {
        response(for: request) { result in
            switch result {
            case .success((let response, let data)):
                guard 200..<300 ~= response.statusCode else {
                    completion(.failure(.requestFailed(response)))
                    return
                }
                
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func decodable<T: Decodable>(for request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkerErrors>) -> (Void)) {
        data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedObject = try decoder.decode(type, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.deserializationFailed(String(describing: type))))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
