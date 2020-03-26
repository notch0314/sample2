//
//  SignUpOperation.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/06.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import Foundation

final class SignUpOperation: Operation {
    
    typealias Output = User
    
    private let name: String
    private let gender: Int
    private let area: String
    private let age: String
    private let bio: String?
    
    init(name: String,
         gender: Int,
         area: String,
         age: String,
         bio: String?) {
        self.name = name
        self.gender = gender
        self.area = area
        self.age = age
        self.bio = bio
    }
    
    var request: Request {
        return APIRequest.signUp(name: name, gender: gender, area: area, age: age, bio: bio)
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<User> {
        return Promise<User>({ resolve, reject,status  in
            do {
                try dispatcher.execute(request: self.request).then({ response in
                    switch response {
                    case .json(let json):
                        let user = try JSONDecoder().decode(User.self, from: json)
                        resolve(user)
                        break
                    case .error(let error):
                        if let e = error {
                            reject(e)
                        }
                        break
                    }
                }).catch(reject)
            } catch {
                reject(error)
            }
        })
    }
}
