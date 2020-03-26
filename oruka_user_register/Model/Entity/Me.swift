//
//  Me.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/06.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import Foundation

final class Me {
    
    static func myUserInfo() ->User? {
        guard let data = UserDefaults.standard.object(forKey: CacheKey.myInfo) as? Data else {
            return nil
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            return nil
        }
    }
}
