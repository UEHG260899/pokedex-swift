//
//  Pokemon.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 16/08/22.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = URL(string: try container.decode(String.self, forKey: .url))!
    }
}
