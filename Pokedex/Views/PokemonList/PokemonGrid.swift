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
        ScrollView {
            LazyVGrid(columns: pokemonColumns, spacing: 20) {
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                Text("Hola")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
            }
            .padding()
        }
    }
}

struct PokemonGrid_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGrid()
    }
}
