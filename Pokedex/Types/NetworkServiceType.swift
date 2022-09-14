//
//  NetworkServiceType.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import Foundation

protocol NetworkServiceType {
    
    /// The URL components used to build a request
    var components: URLComponents { get }
    
    /// Function that builds the URLRequest that will be used in other methods
    /// - Parameters:
    ///   - method: HTTP method to be used in the request
    ///   - path: Endpoint path
    ///   - parameters: Query parameters
    /// - Returns: Complete URLRequest
    func buildRequest(method: Networker.HTTPMethods, path: String, parameters: [String: String]) -> URLRequest
    
    /// Function that builds an URLRequest from a previously formed URL
    /// - Parameters:
    ///   - url: URL that will conform the request
    ///   - method: HTTP method to be used in the request
    /// - Returns: Complete URL
    func buildRequest(url: URL, method: Networker.HTTPMethods) -> URLRequest
}

extension NetworkServiceType {
    
    var components: URLComponents {
        var innerComponents = URLComponents()
        innerComponents.scheme = "https"
        innerComponents.host = "pokeapi.co"
        return innerComponents
    }
    
}
