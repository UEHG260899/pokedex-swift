//
//  PokeminCell.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 14/08/22.
//

import SwiftUI

struct PokemonCell: View {
    
    let width: CGFloat
    let pokemonTypeColor: AppConfigurations.PokemonTypeColors
    
    var body: some View {
        VStack {
            ZStack {
                Color(pokemonTypeColor.rawValue)
                    .frame(width: width, height: 150)
                Image("Bulbasaur")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            Text("Bulbasaur")
                .customFont(.titilliumRegular, size: 17, relativeTo: .body)
                .padding()
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color("Accent"),radius: 10, x: 5, y: 5)
    }
}

struct PokeminCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(width: 200, pokemonTypeColor: .plantType)
            .previewLayout(.sizeThatFits)
    }
}
