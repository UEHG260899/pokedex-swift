//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import Foundation

protocol PokemonListServiceType {
    /// Fetches the initial pokemon list
    /// - Parameters:
    ///   - limit: Number of pokemons to be fetched
    ///   - offset: Offset quantity
    ///   - completion: Completion handler for the request
    func pokemons(limit: Int, offset: Int, completion: @escaping (Result<[Pokemon], NetworkerErrors>) -> Void)
}

struct PokemonListService: NetworkServiceType, PokemonListServiceType {
    
    private let networker: Networker
    
    init(networker: Networker) {
        self.networker = networker
    }
    
    func buildRequest(method: HTTPMethods, path: String, parameters: [String : String] = [:]) -> URLRequest {
        var components = components
        components.path = path
        components.queryItems = parameters.map {  URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
    
    func buildRequest(url: URL, method: HTTPMethods) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    func pokemons(limit: Int, offset: Int, completion: @escaping (Result<[Pokemon], NetworkerErrors>) -> Void) {
        let params = [
            "limit": String(limit),
            "offset": String(offset)
        ]
        let request = buildRequest(method: .get, path: "/api/v2/pokemon", parameters: params)
        
        networker.decodable(for: request, type: PokemonList.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
