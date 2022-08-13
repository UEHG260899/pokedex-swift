//
//  Text+Extensions.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 13/08/22.
//

import SwiftUI

extension Text {
    func customFont(_ font: AppConfigurations.FontFamilies, size:  CGFloat, relativeTo textStyle: Font.TextStyle) -> some View {
        self
            .font(Font.custom(font.rawValue, size: size, relativeTo: textStyle))
    }
}
