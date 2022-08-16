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
    func pokemons(limit: Int, offset: Int, completion: @escaping (Result<Any, Networker.NetworkerErrors>) -> Void)
    /// Fetches a pokemon Image
    /// - Parameters:
    ///   - url: Image url
    ///   - completion: Completion handler for the request
    func pokemonImage(url: URL, completion: @escaping (Result<Data, Networker.NetworkerErrors>) -> Void)
}
