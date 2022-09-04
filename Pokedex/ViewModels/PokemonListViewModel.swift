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
        
        let networker: Networker
        
        var networkState: NetworkState = .loading
        
        init(networker: Networker) {
            self.networker = networker
        }
        
    }
}
