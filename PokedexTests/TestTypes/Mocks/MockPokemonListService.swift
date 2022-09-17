//
//  MockPokemonListService.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 13/09/22.
//

@testable import Pokedex
import Foundation

class MockPokemonListService: PokemonListServiceType {
    
    var shouldCompleteSuccessfully: Bool!
    
    let pokemons = [
        Pokemon(name: "Pikacchu", url: URL(string: "https://www.pokemon.com/el/pokedex/bulbasaur")!),
        Pokemon(name: "Pikacchu2", url: URL(string: "https://www.pokemon.com/el/pokedex/bulbasaur")!),
        Pokemon(name: "Pikacchu3", url: URL(string: "https://www.pokemon.com/el/pokedex/bulbasaur")!),
        Pokemon(name: "Pikacchu4", url: URL(string: "https://www.pokemon.com/el/pokedex/bulbasaur")!)
    ]
    
    func pokemons(limit: Int, offset: Int, completion: @escaping (Result<[Pokemon], NetworkerErrors>) -> Void) {
        if shouldCompleteSuccessfully {
            completion(.success(pokemons))
        } else {
            completion(.failure(.unknown))
        }
    }
    
    
}
