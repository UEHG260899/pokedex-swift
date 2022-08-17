//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 50, maximum: 100), spacing: 10)]
    }
    
    var statsColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 50, maximum: 200), spacing: 10), count: 2)
    }
    
    var body: some View {
        ZStack {
            Color(AppConfigurations.PokemonTypeColors.plantType.rawValue)
                .ignoresSafeArea()
            
            VStack {
                Image("Bulbasaur")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(1...100, id: \.self) { num in
                            Text(String(num))
                        }
                    }
                    .padding(.bottom, 0.1) // Solves ScrollView not respecting bottom safe area
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.white
                        .cornerRadius(12)
                        .ignoresSafeArea(edges: .bottom)
                )
                
            }
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
//            PokemonDetailsView()
//                .navigationTitle(Text("Bulbasaur"))
//                .navigationBarTitleDisplayMode(.inline)
//        }
        PokemonDetailsView()
    }
}
