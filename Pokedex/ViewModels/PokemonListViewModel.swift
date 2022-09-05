//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 03/09/22.
//

import Foundation

enum NetworkState {
    case loading
    case failure
    case success
}

extension PokemonListView {
    class PokemonListViewModel: ObservableObject {
        
        @Published var query = ""
        @Published var pokemons = [BasicPokemonViewModel]()
        
        let service: PokemonListServiceType
        
        var networkState: NetworkState = .loading
        
        init(service: PokemonListServiceType) {
            self.service = service
        }
        
        func fetchPokemons(completion: ((Bool) -> Void)? = nil) {
            service.pokemons(limit: 50, offset: Int.random(in: 1...50)) { result in
                switch result {
                case .success(let pokemons):
                    DispatchQueue.main.async {
                        self.pokemons = pokemons.map { BasicPokemonViewModel.init(pokemon: $0) }
                        self.networkState = .success
                        completion?(true)
                    }
                case .failure(let error):
                    print("F")
                }
            }
        }
    }
}
