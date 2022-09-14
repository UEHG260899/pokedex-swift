//
//  PokemonList.swift
//  Pokedex
//
//  Created by Uriel Hernandez Gonzalez on 16/08/22.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int64
    let next: URL?
    let previous: URL?
    let results: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int64.self, forKey: .count)
        next = URL(string: (try container.decodeIfPresent(String.self, forKey: .next) ?? ""))
        previous = URL(string: (try container.decodeIfPresent(String.self, forKey: .previous) ?? ""))
        results = try container.decode([Pokemon].self, forKey: .results)
    }
}
