//
//  URLSession+Extensions.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 17/09/22.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func makeDataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        return dataTask(with: request, completionHandler: completion)
    }
}

extension URLSessionTask: URLSessionTaskProtocol { }

