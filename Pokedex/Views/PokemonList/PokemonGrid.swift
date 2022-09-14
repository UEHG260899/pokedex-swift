//
//  PokemonGrid.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

struct PokemonGrid: View {
    
    let pokemons: [BasicPokemonViewModel]
    
    var pokemonColumns: [GridItem] {
        [GridItem(.flexible(minimum: 150, maximum: .infinity), spacing: 20),
         GridItem(.flexible(minimum: 150, maximum: .infinity), spacing: 20)]
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: pokemonColumns, spacing: 20) {
                    ForEach(pokemons, id: \.url) { pokemon in
                        NavigationLink(destination: PokemonDetailsView()) {
                            PokemonCell(pokemon: pokemon, width: proxy.size.width / 2 - 20,
                                        pokemonTypeColor: .plantType)
                        }
                    }
                }
                .padding()
            }
            .padding(.bottom, 0.1)
        }
    }
}

struct PokemonGrid_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGrid(pokemons: [BasicPokemonViewModel]())
    }
}
