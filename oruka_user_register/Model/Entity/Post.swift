//
//  Post.swift
//  oruka_user_register
//
//  Created by Ryosuke Inoue on 2019/07/13.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import Foundation

class Post: Codable {
    let id: UInt64
    let text: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
        case user = "user"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        user = try values.decode(User.self, forKey: .user)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(user, forKey: .user)
    }
}
