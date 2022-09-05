//
//  BasicPokemonViewModel.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 05/09/22.
//

import Foundation

struct BasicPokemonViewModel {
    
    let pokemon: Pokemon
    
    var name: String {
        pokemon.name
    }
    
    var url: URL {
        pokemon.url
    }
    
    var imageUrl: URL {
        let components = url.absoluteString.components(separatedBy: "/").filter { !$0.isEmpty }
        let pokemonId = components.last ?? "1"
        let completeId = String(format: "%03d", Int(pokemonId)!)
        return URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(completeId).png")!
    }
    
}
