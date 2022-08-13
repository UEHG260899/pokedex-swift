//
//  Text+Extensions.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

extension Text {
    func customFont(_ font: String) -> some View {
        self
            .font(Font.custom(font, size: 17, relativeTo: .body))
    }
}
