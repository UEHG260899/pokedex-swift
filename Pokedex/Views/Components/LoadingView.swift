//
//  LoadingView.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 04/09/22.
//

import SwiftUI

struct LoadingView: View {
    
    let progressTitle: String?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView {
                    Text(progressTitle ?? "")
                        .customFont(.titilliumSemiBold, size: 12, relativeTo: .body)
                }
                .progressViewStyle(.circular)
                .scaleEffect(1.5, anchor: .center)
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(progressTitle: "Fetching pokemons")
    }
}
