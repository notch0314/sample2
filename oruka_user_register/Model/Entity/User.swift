//
//  User.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/06.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import Foundation

class User: Codable {
    let id: UInt64
    let name: String
    let gender: Gender
    let age: Int
    let area: String
    let bio: String?
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case gender = "gender"
        case age = "age"
        case area = "area"
        case bio = "bio"
        case token = "token"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        gender = Gender.init(rawValue: try values.decode(Int.self, forKey: .gender)) ?? .notset
        age = try values.decode(Int.self, forKey: .age)
        area = try values.decode(String.self, forKey: .area)
        if let bio = try values.decodeIfPresent(String.self, forKey: .bio) {
            self.bio = bio
        } else {
            self.bio = nil
        }
        token = try values.decode(String.self, forKey: .token)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(gender.rawValue, forKey: .gender)
        try container.encode(age, forKey: .age)
        try container.encode(area, forKey: .area)
        try container.encode(bio, forKey: .bio)
        try container.encode(token, forKey: .token)
    }
}

