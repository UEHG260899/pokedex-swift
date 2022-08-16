//
//  RootView.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            PokemonListView()
        }
        .navigationViewStyle(.stack)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
