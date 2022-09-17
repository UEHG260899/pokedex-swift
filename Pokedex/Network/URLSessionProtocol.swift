//
//  URLSessionProtocol.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 17/09/22.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    func makeDataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
}

protocol URLSessionTaskProtocol: AnyObject {
    func resume()
}
