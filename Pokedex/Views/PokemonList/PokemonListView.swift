//
//  PolemonListView.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

struct PokemonListView: View {
    
    @State var query = ""
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                PokemonTextField(query: $query, placeholderText: "Search a pokemon...", keyBoardType: .default)
                    .padding(.horizontal)
            }
        }
    }
}

struct PolemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
