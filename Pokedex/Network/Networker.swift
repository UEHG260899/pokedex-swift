//
//  Networker.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

enum NetworkerErrors: Error, Equatable {
    case unknown
    case invalidResponse(URLResponse)
    case requestFailed(HTTPURLResponse)
    case deserializationFailed(String)
}




struct Networker {
    
    let session: URLSessionProtocol
    
    @discardableResult
    func response(for request: URLRequest, completion: @escaping (Result<(HTTPURLResponse, Data), NetworkerErrors>) -> (Void)) -> URLSessionTaskProtocol {
        let task = session.makeDataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response,
                  error == nil else {
                debugPrint(error?.localizedDescription)
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse(response)))
                return
            }
            
            completion(.success((httpResponse, data)))
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func data(for request: URLRequest, completion: @escaping (Result<Data, NetworkerErrors>) -> (Void)) -> URLSessionTaskProtocol {
        return response(for: request) { result in
            
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
    
    func decodable<T: Decodable>(for request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkerErrors>) -> (Void)) -> URLSessionTaskProtocol {
        return data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.deserializationFailed(String(describing: type))))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
