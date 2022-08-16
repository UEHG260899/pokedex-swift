//
//  MockPost.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import Foundation

struct MockPost: Decodable {
    let id: Int64
    let title: String
    let body: String
    let userId: Int64
    
    enum CodingKeys: String, CodingKey {
        case id, title, body, userId
    }
    
    
    init(id: Int64, title: String, body: String, userId: Int64) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        userId = try container.decode(Int64.self, forKey: .userId)
    }
}

extension MockPost: Equatable {
    static func == (lhs: MockPost, rhs: MockPost) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.body == rhs.body &&
        lhs.userId == rhs.userId
    }
}
