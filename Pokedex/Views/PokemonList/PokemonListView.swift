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
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Let´s catch them all!")
                    .customFont(.titilliumBold, size: 28, relativeTo: .title)
                    .padding(.horizontal)
                    .foregroundColor(Color("Accent"))
                
                PokemonTextField(query: $query,
                                 placeholderText: "Search a pokemon...",
                                 keyBoardType: .default)
                    .padding(.horizontal)
                
                PokemonGrid()
            }
        }
        .navigationBarHidden(true)
    }
}

struct PolemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
