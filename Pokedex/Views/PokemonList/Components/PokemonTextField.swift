//
//  PokemonTextField.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

struct PokemonTextField: View {
    @Binding var query: String
    let placeholderText: String
    let keyBoardType: UIKeyboardType
    
    var body: some View {
        ZStack(alignment: .leading) {
            if query.isEmpty {
                Text(placeholderText)
                    .customFont(.titilliumRegular, size: 17, relativeTo: .body)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            TextField("", text: $query)
                .foregroundColor(.white)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .foregroundColor(Color("Accent"))
        )
    }
}

struct PokemonTextField_Previews: PreviewProvider {
    
    @State static var query = ""
    static var placeholderText = "Search a Pokemon..."
    
    static var previews: some View {
        PokemonTextField(query: $query, placeholderText: placeholderText, keyBoardType: .default)
            .background(Color("Background"))
            .previewLayout(.sizeThatFits)
    }
}
