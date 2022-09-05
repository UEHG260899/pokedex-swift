//
//  LoadingView.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 04/09/22.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isRotated: Bool
    
    let progressTitle: String?
    
    var degress: Angle {
        .degrees(isRotated ? 360 : 0)
    }
    
    var animation: Animation {
        Animation.easeInOut(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image("pokeball")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .rotationEffect(degress)
                        .animation(animation, value: isRotated)
                    Text(progressTitle ?? "")
                        .customFont(.titilliumSemiBold, size: 14.0, relativeTo: .body)
                }
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            isRotated.toggle()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isRotated: .constant(true),progressTitle: "Fetching pokemons")
    }
}
