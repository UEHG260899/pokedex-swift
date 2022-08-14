//
//  TextField+Extensions.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

extension TextField {
    func customFont(_ font: AppConfigurations.FontFamilies, size: CGFloat) -> some View {
        self
            .font(Font.custom(font.rawValue, size: size))
    }
}
