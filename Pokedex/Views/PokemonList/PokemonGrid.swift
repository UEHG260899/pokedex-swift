//
//  PokemonGrid.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

struct PokemonGrid: View {
    
    var pokemonColumns: [GridItem] {
        [GridItem(.flexible(minimum: 150, maximum: .infinity), spacing: 20),
         GridItem(.flexible(minimum: 150, maximum: .infinity), spacing: 20)]
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: pokemonColumns, spacing: 20) {
                    ForEach(1...10, id: \.self) { _ in
                        NavigationLink(destination: PokemonDetailsView()) {
                            PokemonCell(width: proxy.size.width / 2 - 20,
                                        pokemonTypeColor: .plantType)
                        }
                    }
                }
                .padding()
            }
            .padding(.bottom)
        }
    }
}

struct PokemonGrid_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGrid()
    }
}
