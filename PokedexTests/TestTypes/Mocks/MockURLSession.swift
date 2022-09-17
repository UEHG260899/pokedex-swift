//
//  MockURLSession.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 17/09/22.
//

import Foundation
@testable import Pokedex

class MockURLSession: URLSessionProtocol {
    func makeDataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Pokedex.URLSessionTaskProtocol {
        return MockURLSessionDataTask(request: request, completionHandler: completion)
    }
}

class MockURLSessionDataTask: URLSessionTaskProtocol {
        
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var request: URLRequest
    var calledResume = false
    
    init(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.request = request
        self.completionHandler = completionHandler
    }
    
    
    func resume() {
        calledResume = true
    }
    
    
}
